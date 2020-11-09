//
//  PHPickerView.swift
//  Films
//
//  Created by Javier Fernández on 09/11/2020.
//

import SwiftUI
import PhotosUI

// PHPickerView -> es la nueva manera de representar la selección de fotos a partir de iOS 14.
// UIViewControllerRepresentable / UIViewRepresentable -> Para representar/extraer algo de UIKit en SwiftUI

struct PHPickerView: UIViewControllerRepresentable {
    @Binding var cover:UIImage?
    typealias UIViewControllerType = PHPickerViewController // Indicamos que tipo de View queremos representar
    
    // En el caso que nuestra View tenga delegados, lo hacemos a traves de nuestro Coordinator
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        @Binding var cover:UIImage?
        
        init(cover:Binding<UIImage?>) {
            _cover = cover
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true, completion: nil)
            let itemProvider = results.map(\.itemProvider)
            
            if let item = itemProvider.first, item.canLoadObject(ofClass: UIImage.self) {
               item.loadObject(ofClass: UIImage.self) { image, error in
                    if let image = image as? UIImage {
                        self.cover = image
                    }
               }
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(cover: $cover)
    }
    
    // Estas dos funciones son obligatorias y se crea a raiz del typealias
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
}
