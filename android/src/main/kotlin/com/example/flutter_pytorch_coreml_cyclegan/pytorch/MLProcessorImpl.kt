package com.example.flutter_pytorch_coreml_cyclegan.pytorch

import android.graphics.Bitmap
import android.graphics.Color
import org.pytorch.IValue
import org.pytorch.Module
import org.pytorch.torchvision.TensorImageUtils

class MLProcessorImpl(
    modelPath: String,
    override val width: Int,
    override val height: Int): MLProcessor {

    override val module = Module.load(modelPath)

    override fun process(bitmap: Bitmap): Bitmap {
        val inputTensor = TensorImageUtils.bitmapToFloat32Tensor(
            bitmap, FloatArray(3) { RGB_MEAN * 3 }, FloatArray(3) { RGB_STD * 3 }
        )
        val outputTensor = module.forward(IValue.from(inputTensor))
            .toTensor().dataAsFloatArray
        return outputTensor.bitmap
    }

    private val FloatArray.bitmap: Bitmap
        get() {
            val bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888)
            val totalPixels = width * height
            val pixelArray = IntArray(totalPixels)

            val denorm = { n: Float -> (n * RGB_STD) + RGB_MEAN }

            for (i in 0 until totalPixels) {
                pixelArray[i] = Color.rgb(
                    denorm(this[i]), denorm(this[i + totalPixels]), denorm(this[i + 2 * totalPixels])
                )
            }
            bitmap.setPixels(pixelArray, 0, width, 0, 0, width, height)
            return bitmap
        }

    companion object {
        private const val RGB_MEAN = 0.5f
        private const val RGB_STD = 0.5f
    }
}