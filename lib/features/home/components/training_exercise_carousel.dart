import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/index.dart';
import '../../../shared/binds.dart';

typedef CarouselSlideBuilder =
    Widget Function(
      BuildContext context,
      ResourceField resource,
      String title,
      String subtitle,
    );

class _CarouselSlide {
  final ResourceField resource;
  final String title;
  final String subtitle;
  const _CarouselSlide(this.resource, this.title, this.subtitle);
}

/// Wrapper que rotaciona exercícios de tempos em tempos e repassa o
/// recurso/título/subtítulo atuais para o `builder`.
///
/// - Se `exercises` não estiver vazio: lista = exercícios de hoje (cada
///   um resolvido para um [ResourceField] via [ResourceRepository]).
/// - Se vazio: pega até [fallbackCount] recursos aleatórios de
///   `resources.generated.dart`.
class TrainingExerciseCarousel extends StatefulWidget {
  final Duration interval;
  final int fallbackCount;
  final Exercises exercises;
  final CarouselSlideBuilder builder;

  const TrainingExerciseCarousel({
    super.key,
    required this.builder,
    required this.exercises,
    this.interval = const Duration(seconds: 5),
    this.fallbackCount = 5,
  });

  @override
  State<TrainingExerciseCarousel> createState() => _TrainingExerciseCarouselState();
}

class _TrainingExerciseCarouselState extends State<TrainingExerciseCarousel> {
  late final ResourceRepository _resourceRepository;

  Timer? _timer;
  int _index = 0;
  List<_CarouselSlide> _slides = const [];

  @override
  void initState() {
    super.initState();
    _resourceRepository = Binds.get<ResourceRepository>();

    _buildSlides();
    _startTimer();
  }

  @override
  void didUpdateWidget(covariant TrainingExerciseCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_listEquals(oldWidget.exercises, widget.exercises)) {
      _buildSlides();
      _index = 0;
      _startTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  bool _listEquals(Exercises a, Exercises b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i].id != b[i].id) return false;
    }
    return true;
  }

  void _buildSlides() {
    if (widget.exercises.isNotEmpty) {
      _slides = widget.exercises.map((e) {
        final resource = _resourceRepository.findByIdOrNull(e.urlId) ?? _randomFallback();
        return _CarouselSlide(resource, e.workoutName, e.name);
      }).toList();
      return;
    }

    final all = [..._resourceRepository.all()]..shuffle();
    _slides = all.take(widget.fallbackCount).map((r) => _CarouselSlide(r, r.segment.toUpperCase(), r.name)).toList();
  }

  ResourceField _randomFallback() {
    final all = [..._resourceRepository.all()]..shuffle();
    return all.first;
  }

  void _startTimer() {
    _timer?.cancel();
    if (_slides.length <= 1) return;
    _timer = Timer.periodic(widget.interval, (_) {
      if (!mounted) return;
      setState(() => _index = (_index + 1) % _slides.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_slides.isEmpty) return const SizedBox.shrink();
    final slide = _slides[_index];
    return widget.builder(context, slide.resource, slide.title, slide.subtitle);
  }
}
