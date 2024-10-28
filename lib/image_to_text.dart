/*import 'dart:async';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

class RealTimeOCRScreen extends StatefulWidget {
  @override
  _RealTimeOCRScreenState createState() => _RealTimeOCRScreenState();
}

class _RealTimeOCRScreenState extends State<RealTimeOCRScreen> {
  late CameraController _cameraController;
  bool _isDetecting = false;
  String _detectedText = "";
  PoseDetector? _poseDetector;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _loadTFLiteModel();
    _poseDetector = PoseDetector(options: PoseDetectorOptions());
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front);

    _cameraController = CameraController(
      camera,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await _cameraController.initialize();
    _cameraController.startImageStream(_processCameraImage);
  }

  Future<void> _loadTFLiteModel() async {
    await Tflite.loadModel(
      model: "assets/ocr_model.tflite",
    );
  }

  void _processCameraImage(CameraImage image) {
    if (_isDetecting) return; // Avoid multiple detections simultaneously

    setState(() {
      _isDetecting = true;
    });

    // Convert the image to the format expected by TFLite
    final Uint8List bytes = _convertCameraImageToBytes(image);

    // Run TFLite model on the frame
    Tflite.runModelOnBinary(
      binary: bytes,
      numResults: 1,
      threshold: 0.5,
    ).then((recognitions) {
      if (recognitions != null && recognitions.isNotEmpty) {
        setState(() {
          _detectedText = recognitions[0]["label"];
        });
      }

      // Perform skeleton detection using MediaPipe
      _detectSkeleton(image).then((skeletons) {
        if (skeletons.isNotEmpty) {
          print("Skeletons detected: $skeletons");
        }

        setState(() {
          _isDetecting = false;
        });
      });
    });
  }

  Uint8List _convertCameraImageToBytes(CameraImage image) {
    final bytes = image.planes.map((plane) {
      return plane.bytes;
    }).expand((byte) => byte).toList();
    return Uint8List.fromList(bytes); // Convert List<int> to Uint8List
  }

  Future<List<Pose>> _detectSkeleton(CameraImage image) async {
    // Convert CameraImage to InputImage for MediaPipe
    final inputImage = InputImage.fromBytes(
      bytes: _convertCameraImageToBytes(image),
      inputImageData: InputImageData(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        imageRotation: InputImageRotation.rotation90deg,
        inputImageFormat: InputImageFormat.yuv420, // Ensure this matches your library version
        planeData: image.planes.map((Plane plane) {
          return InputImagePlaneMetadata(
            bytesPerRow: plane.bytesPerRow,
            height: plane.height,
            width: plane.width,
          );
        }).toList(),
      ),
    );

    // Process the image to detect skeletons
    final List<Pose> poses = await _poseDetector!.processImage(inputImage);
    return poses;
  }

  @override
  void dispose() {
    _cameraController.dispose();
    Tflite.close();
    _poseDetector?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Real-Time OCR with Skeleton Detection'),
      ),
      body: Stack(
        children: [
          if (_cameraController.value.isInitialized)
            CameraPreview(_cameraController),
          Positioned(
            bottom: 20,
            left: 10,
            right: 10,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.greenAccent.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _detectedText.isEmpty ? 'No text detected' : _detectedText,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/