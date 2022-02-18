//
//  Camera.swift
//  Journal.it
//
//  Created by Mark Howard on 02/02/2022.
//

import SwiftUI
import SwiftUIKit
import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI

struct Camera: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var photos = [Image]()
    @StateObject var sheetContext = FullScreenCoverContext()
    @State var vignetteFilter = CIFilter.vignette()
    @State var sepiaFilter = CIFilter.sepiaTone()
    @State var sharpnessFilter = CIFilter.noiseReduction()
    @State var gaussianBlurFilter = CIFilter.gaussianBlur()
    @State var motionBlurFilter = CIFilter.motionBlur()
    @State var zoomBlurFilter = CIFilter.zoomBlur()
    @State var exposureFilter = CIFilter.exposureAdjust()
    @State var gammaFilter = CIFilter.gammaAdjust()
    @State var hueFilter = CIFilter.hueAdjust()
    @State var vibranceFilter = CIFilter.vibrance()
    let context = CIContext()
    @State var showingImagePicker = false
    @State var inputImage: UIImage?
    @State var image: Image?
    @State var vignetteIntensity = 0.0
    @State var sepiaIntensity = 0.0
    @State var sharpnessIntensity = 0.0
    @State var gaussianBlurintensity = 0.0
    @State var motionBlurIntensity = 0.0
    @State var zoomBlurIntensity = 0.0
    @State var exposureIntensity = 0.0
    @State var gammaIntensity = 1.0
    @State var hueIntensity = 0.0
    @State var vibranceIntensity = 0.0
    @State var showingEditor = false
    @State private var processedImage: UIImage?
    var body: some View {
        if horizontalSizeClass == .compact {
            NavigationView {
                HStack {
                    Spacer()
                Button(action: {openCamera()}) {
                    Label("Open Camera", systemImage: "camera.fill")
                }
                .buttonStyle(.bordered)
                .tint(.accentColor)
                    Spacer()
                    Button(action: {self.showingEditor = true}) {
                        Label("Edit Photo", systemImage: "photo.on.rectangle")
                    }
                    .buttonStyle(.bordered)
                    .tint(.accentColor)
                    .sheet(isPresented: $showingEditor) {
                        editor
                    }
                    Spacer()
                    .navigationTitle("Camera")
                    .navigationBarTitleDisplayMode(.inline)
            }
            }
            .fullScreenCover(context: sheetContext)
            .onChange(of: inputImage) { _ in loadImage() }
        } else {
            HStack {
                Spacer()
            Button(action: {openCamera()}) {
                Label("Open Camera", systemImage: "camera.fill")
            }
            .buttonStyle(.bordered)
            .tint(.accentColor)
                Spacer()
                Button(action: {self.showingEditor = true}) {
                    Label("Edit Photo", systemImage: "photo.on.rectangle")
                }
                .buttonStyle(.bordered)
                .tint(.accentColor)
                .sheet(isPresented: $showingEditor) {
                    editor
                }
                Spacer()
            }
                .navigationTitle("Camera")
                .navigationBarTitleDisplayMode(.inline)
                .fullScreenCover(context: sheetContext)
                .onChange(of: inputImage) { _ in loadImage() }
        }
    }
    var editor: some View {
        NavigationView {
            VStack {
                image?
                    .resizable()
                    .scaledToFit()
                    .padding()
                Button(action: {self.showingImagePicker = true}) {
                    Label("Select Image", systemImage: "photo")
                }
                .buttonStyle(.bordered)
                .tint(.accentColor)
                .padding()
                .sheet(isPresented: $showingImagePicker) {
                    ImagePicker(image: $inputImage)
                }
                Divider()
                Form {
                    HStack {
                        Text("Vignette")
                        Spacer()
                        Slider(value: $vignetteIntensity)
                                .padding(.horizontal)
                            .onChange(of: vignetteIntensity) { _ in
                                applyProcessing()
                            }
                    }
                    HStack {
                        Text("Sepia")
                        Spacer()
                        Slider(value: $sepiaIntensity)
                                .padding(.horizontal)
                            .onChange(of: sepiaIntensity) { _ in
                                applyProcessing()
                            }
                    }
                    HStack {
                        Text("Sharpness")
                        Spacer()
                        Slider(value: $sharpnessIntensity)
                            .padding(.horizontal)
                            .onChange(of: sharpnessIntensity) { _ in
                                applyProcessing()
                            }
                    }
                    HStack {
                        Text("Gaussian Blur")
                        Spacer()
                        Slider(value: $gaussianBlurintensity)
                            .padding(.horizontal)
                            .onChange(of: gaussianBlurintensity) { _ in
                                applyProcessing()
                            }
                    }
                    HStack {
                        Text("Motion Blur")
                        Spacer()
                        Slider(value: $motionBlurIntensity)
                            .padding(.horizontal)
                            .onChange(of: motionBlurIntensity) { _ in
                                applyProcessing()
                            }
                    }
                    HStack {
                        Text("Zoom Blur")
                        Spacer()
                        Slider(value: $zoomBlurIntensity)
                            .padding(.horizontal)
                            .onChange(of: zoomBlurIntensity) { _ in
                                applyProcessing()
                            }
                    }
                    HStack {
                        Text("Exposure")
                        Spacer()
                        Slider(value: $exposureIntensity)
                            .padding(.horizontal)
                            .onChange(of: exposureIntensity) { _ in
                                applyProcessing()
                            }
                    }
                    HStack {
                        Text("Gamma")
                        Spacer()
                        Slider(value: $gammaIntensity)
                            .padding(.horizontal)
                            .onChange(of: gammaIntensity) { _ in
                                applyProcessing()
                            }
                    }
                    HStack {
                        Text("Hue")
                        Spacer()
                        Slider(value: $hueIntensity)
                            .padding(.horizontal)
                            .onChange(of: hueIntensity) { _ in
                                applyProcessing()
                            }
                    }
                    HStack {
                        Text("Vibrance")
                        Spacer()
                        Slider(value: $vibranceIntensity)
                            .padding(.horizontal)
                            .onChange(of: vibranceIntensity) { _ in
                                applyProcessing()
                            }
                    }
                }
            }
            .padding(.vertical)
                .navigationTitle("Editor")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {self.showingEditor = false}) {
                            Text("Cancel")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {guard let processedImage = processedImage else { return }
                            
                            let imageSaver = ImageSaver()
                            imageSaver.writeToPhotoAlbum(image: processedImage)
                            self.showingEditor = false
                        }) {
                            Text("Save")
                        }
                    }
                }
        }
    }
    func loadImage() {
        guard let inputImage = inputImage else { return }

        let beginImage = CIImage(image: inputImage)
        vignetteFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    func applyProcessing() {
        vignetteFilter.intensity = Float(vignetteIntensity)
        guard let imageWithFilter = vignetteFilter.value(forKey: kCIOutputImageKey) as? CIImage else { return }
        sepiaFilter.setValue(imageWithFilter, forKey: kCIInputImageKey)
        sepiaFilter.intensity = Float(sepiaIntensity)
        guard let imageWithBoth = sepiaFilter.value(forKey: kCIOutputImageKey) as? CIImage else { return }
        sharpnessFilter.setValue(imageWithBoth, forKey: kCIInputImageKey)
        sharpnessFilter.sharpness = Float(sharpnessIntensity)
        guard let imageWith3 = sharpnessFilter.value(forKey: kCIOutputImageKey) as? CIImage else { return }
        gaussianBlurFilter.setValue(imageWith3, forKey: kCIInputImageKey)
        gaussianBlurFilter.radius = Float(gaussianBlurintensity)
        guard let imageWith4 = gaussianBlurFilter.value(forKey: kCIOutputImageKey) as? CIImage else { return }
        motionBlurFilter.setValue(imageWith4, forKey: kCIInputImageKey)
        motionBlurFilter.radius = Float(motionBlurIntensity)
        guard let imageWith5 = motionBlurFilter.value(forKey: kCIOutputImageKey) as? CIImage else { return }
        zoomBlurFilter.setValue(imageWith5, forKey: kCIInputImageKey)
        zoomBlurFilter.amount = Float(zoomBlurIntensity)
        guard let imageWith6 = zoomBlurFilter.value(forKey: kCIOutputImageKey) as? CIImage else { return }
        exposureFilter.setValue(imageWith6, forKey: kCIInputImageKey)
        exposureFilter.ev = Float(exposureIntensity)
        guard let imageWith7 = exposureFilter.value(forKey: kCIOutputImageKey) as? CIImage else { return }
        gammaFilter.setValue(imageWith7, forKey: kCIInputImageKey)
        gammaFilter.power = Float(gammaIntensity)
        guard let imageWith8 = gammaFilter.value(forKey: kCIOutputImageKey) as? CIImage else { return }
        hueFilter.setValue(imageWith8, forKey: kCIInputImageKey)
        hueFilter.angle = Float(hueIntensity)
        guard let imageWith9 = hueFilter.value(forKey: kCIOutputImageKey) as? CIImage else { return }
        vibranceFilter.setValue(imageWith9, forKey: kCIInputImageKey)
        vibranceFilter.amount = Float(vibranceIntensity)
        guard let imageWith10 = vibranceFilter.value(forKey: kCIOutputImageKey) as? CIImage else { return }
        
        if let cgimg = context.createCGImage(imageWith10, from: imageWith10.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
}

struct Camera_Previews: PreviewProvider {
    static var previews: some View {
        Camera()
    }
}

extension Camera {
    
    func createCamera() -> some View {
        PhotoCamera(
            cancelAction: dismissCamera,
            resultAction: handleResult)
            .edgesIgnoringSafeArea(.all)
    }
    
    func dismissCamera() {
        sheetContext.dismiss()
    }
    
    func handleResult(_ result: PhotoCamera.CameraResult) {
        switch result {
        case .failure: dismissCamera()
        case .success(let photo): savePhoto(photo)
        }
    }
    
    func openCamera() {
        sheetContext.present(createCamera())
    }
    
    func savePhoto(_ photo: ImageResource) {
        let image: Image = Image(imageResource: photo)
        let uiImage: UIImage = image.asUIImage()
        UIImageWriteToSavedPhotosAlbum(uiImage, nil, nil, nil)
        dismissCamera()
    }
}

extension View {
    public func asUIImage() -> UIImage {
        let controller = UIHostingController(rootView: self)
        
        controller.view.frame = CGRect(x: 0, y: CGFloat(Int.max), width: 1, height: 1)
        UIApplication.shared.windows.first!.rootViewController?.view.addSubview(controller.view)
        
        let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
        controller.view.bounds = CGRect(origin: .zero, size: size)
        controller.view.sizeToFit()
        
        let image = controller.view.asUIImage()
        controller.view.removeFromSuperview()
        return image
    }
}

extension UIView {
    public func asUIImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            guard let provider = results.first?.itemProvider else { return }

            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    self.parent.image = image as? UIImage
                }
            }
        }
    }
}

class ImageSaver: NSObject {
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?

    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveComplete), nil)
    }

    @objc func saveComplete(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
}
