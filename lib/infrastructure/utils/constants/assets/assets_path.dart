import 'package:matrix_campus/infrastructure/utils/constants/assets/gif_assets.dart';
import 'package:matrix_campus/infrastructure/utils/constants/assets/jpeg_assets.dart';
import 'package:matrix_campus/infrastructure/utils/constants/assets/lottie_assets.dart';
import 'package:matrix_campus/infrastructure/utils/constants/assets/png_assets.dart';
import 'package:matrix_campus/infrastructure/utils/constants/assets/svg_assets.dart';

class AssetsPath {
  static JpegAssets? _jpgAssets;
  static PngAssets? _pngAssets;
  static SvgAssets? _svgAssets;
  static GifAssets? _gifAssets;
  static LottieAssets? _lottieAssets;

  // Lazy Singleton for JPG assets
  static JpegAssets get jpg {
    _jpgAssets ??= JpegAssets();
    return _jpgAssets!;
  }

  // Lazy Singleton for PNG assets
  static PngAssets get png {
    _pngAssets ??= PngAssets();
    return _pngAssets!;
  }

  // Lazy Singleton for SVG assets
  static SvgAssets get svg {
    _svgAssets ??= SvgAssets();
    return _svgAssets!;
  }

  // Lazy Singleton for gif assets
  static GifAssets get gif {
    _gifAssets ??= GifAssets();
    return _gifAssets!;
  }

  static LottieAssets get lottie {
    _lottieAssets ??= LottieAssets();
    return _lottieAssets!;
  }
}
