import 'dart:async';
import 'package:audioplayer/audioplayer.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

class TrackPreviewPlayer extends StatefulWidget {
  const TrackPreviewPlayer({
    key,
    this.previewUrl,
  }) : super(key: key);

  final String previewUrl;

  @override
  State<StatefulWidget> createState() {
    return _TrackPreviewPlayerState();
  }
}

class _TrackPreviewPlayerState extends State<TrackPreviewPlayer> {
  AudioPlayer _player;
  AudioPlayerState _playerState;
  Duration _playerPosition = Duration(seconds: 0);
  Duration _trackDuration = Duration(seconds: 30);
  StreamSubscription _onPlayerStateChangedSubscription;
  StreamSubscription _onAudioPositionChangedSubscription;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    Widget playerButton;
    if (_playerState == AudioPlayerState.PLAYING) {
      playerButton = IconButton(
        icon: Icon(FeatherIcons.pauseCircle),
        tooltip: 'Pause preview',
        onPressed: onPause,
      );
    } else {
      playerButton = IconButton(
        icon: Icon(FeatherIcons.playCircle),
        tooltip: 'Play preview',
        onPressed: widget.previewUrl != null ? onPlay : null,
      );
    }

    bool active = _playerState == AudioPlayerState.PLAYING ||
        _playerState == AudioPlayerState.PAUSED;

    return Row(
      children: <Widget>[
        playerButton,
        Expanded(
          child: Slider(
            value: _playerPosition.inMilliseconds.toDouble(),
            min: 0.0,
            max: _trackDuration.inMilliseconds.toDouble(),
            onChangeStart: onSliderPositionChangeStart,
            onChanged: active ? onSliderPositionChanged : null,
            onChangeEnd: onSliderPositionChangeEnd,
            activeColor: theme.accentColor,
            inactiveColor: theme.accentColor.withOpacity(0.4),
          ),
        ),
        Text(
          widget.previewUrl != null ? 'Preview' : 'No preview available',
          style: theme.textTheme.caption,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _player?.stop();
    _onAudioPositionChangedSubscription?.cancel();
    _onPlayerStateChangedSubscription?.cancel();

    super.dispose();
  }

  void onPlayerStateChanged(AudioPlayerState s) {
    if (s == AudioPlayerState.PLAYING) {
      setState(() {
        _trackDuration = _player.duration;
      });
    }
    setState(() => _playerState = s);
  }

  void onPlayerAudioPositionChanged(Duration pos) {
    setState(() => _playerPosition = pos);
  }

  void onPlay() {
    _player = AudioPlayer();
    _onPlayerStateChangedSubscription =
        _player.onPlayerStateChanged.listen(onPlayerStateChanged);
    _onAudioPositionChangedSubscription =
        _player.onAudioPositionChanged.listen(onPlayerAudioPositionChanged);

    _player.play(widget.previewUrl);
  }

  void onPause() {
    _player.pause();
  }

  void onSliderPositionChangeStart(double pos) {
    _onAudioPositionChangedSubscription.pause();
  }

  void onSliderPositionChanged(double pos) {
    setState(() {
      _playerPosition = Duration(milliseconds: pos.floor());
    });
  }

  void onSliderPositionChangeEnd(double pos) {
    _player.seek(Duration(milliseconds: pos.floor()).inSeconds.toDouble());
    _onAudioPositionChangedSubscription.resume();
  }
}
