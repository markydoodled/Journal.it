//
//  Camera.swift
//  Journal.it
//
//  Created by Mark Howard on 02/02/2022.
//

import SwiftUI
import SwiftUIKit

struct Camera: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State private var photos = [Image]()
    @StateObject private var sheetContext = FullScreenCoverContext()
    var body: some View {
        if horizontalSizeClass == .compact {
            NavigationView {
                Button(action: {openCamera()}) {
                    Label("Open Camera", systemImage: "camera.fill")
                }
                .buttonStyle(.bordered)
                .tint(.accentColor)
                    .navigationTitle("Camera")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .fullScreenCover(context: sheetContext)
        } else {
            Button(action: {openCamera()}) {
                Label("Open Camera", systemImage: "camera.fill")
            }
            .buttonStyle(.bordered)
            .tint(.accentColor)
                .navigationTitle("Camera")
                .navigationBarTitleDisplayMode(.inline)
                .fullScreenCover(context: sheetContext)
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
