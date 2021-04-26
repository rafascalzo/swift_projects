//
//  Camera.swift
//  Full Square
//
//  Created by Fulltrack Mobile on 16/08/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//
protocol CameraDelegate {
    func saveImage(didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) -> Void
}
import UIKit

class Camera: NSObject {
    
    var delegate : CameraDelegate?
    
    func saveImage(_ image : UIImage?){
        
        let fileSystemPath = NSHomeDirectory()
        let imageDirectory = "Application"
        let fullFileSystemPath = fileSystemPath.appending(imageDirectory)
        
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("yourProjectImages")
        
        let fileManager = FileManager.default
        
        let imageName = String(format: "%@.jpeg", "nomeUnico\(Int.random(in: 0...Int.max))")
        
        let url = URL(fileURLWithPath: String(format: "%@/%@", path ,imageName))
        print(url)
        
        if !fileManager.fileExists(atPath: fullFileSystemPath){
            
            do {
                try fileManager.createDirectory(atPath: path, withIntermediateDirectories: false, attributes: nil)
            }catch{
                print(error.localizedDescription)
            }
        }
        guard let imagem = image else { return }
        
        
       // guard let data = UIImage.pngData(imagem) as? Data else { return }
        
        guard let data = imagem.pngData() else {return}
      
        do {
            try data.write(to: url)
            NSLog("%@ \(data)", "data write: ")
        } catch {
            NSLog("$@ \(error.localizedDescription)", "Error = ")
        }
    }
    
    func saveImageToDevice(_ image : UIImage?){
        guard let image = image else {print("no guard"); return}
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image : UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer){
        delegate?.saveImage(didFinishSavingWithError: error, contextInfo: contextInfo)
    }
    
//    func saveImageDocumentDirectory(){
//        let fileManager = FileManager.default
//        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("apple.jpg")
//        let image = UIImage(named: "apple.jpg")
//        print(paths)
//        //let imageData = UIImageJPEGRepresentation(image!, 0.5)
//        if let imageData:Data = UIImage.jpegData(image?.jpegData(compressionQuality: 12)) {
//            fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
//        }
//    }
    
    func saveImageDocumentDirectory(_ imageName:String){
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        let image = UIImage(named: imageName)
        print(paths)
       // let imageData = UIImageJPEGRepresentation(image!, 0.5)
       // guard let imageData = image!.pngData() else { return }
        guard let data:Data = image!.jpegData(compressionQuality: 1) else {return}
        fileManager.createFile(atPath: paths as String, contents: data, attributes: nil)
    }
   // Get Document Directory Path :
    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    //Get Image from Document Directory :
    func getImage(named name:String){
        let fileManager = FileManager.default
        let imagePAth = (self.getDirectoryPath() as NSString).appendingPathComponent(name)
        
        if fileManager.fileExists(atPath: imagePAth){
            //self.imageView.image = UIImage(contentsOfFile: imagePAth)
            print("image at \(imagePAth)")
        }else{
            print("No Image")
        }
    }
    //Create Directory :
    //https://developer.apple.com/documentation/uikit/uiimage/1624115-jpegdata
    //https://medium.com/@vikaskore/save-get-and-delete-multiple-images-from-document-directory-in-swift-db75e536b72b
    //https://medium.com/@javedmultani16/ios-filemanager-in-swift-e0854c7dfa60
    func createDirectory(){
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("customDirectory”")
        if !fileManager.fileExists(atPath: paths){
            try! fileManager.createDirectory(atPath: paths, withIntermediateDirectories: true, attributes: nil)
        }else{
            print("Already dictionary created.")
        }
    }
   // Delete Directory :
    func deleteDirectory(){
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("customDirectory")
        if fileManager.fileExists(atPath: paths){
            try! fileManager.removeItem(atPath: paths)
        }else{
            print("Something wronge.")
        }
    }
    
//    func saveImageDocumentDirectory(){
//        let fileManager = NSFileManager.defaultManager()
//        let paths = (NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString).stringByAppendingPathComponent(“apple.jpg”)
//        let image = UIImage(named: “apple.jpg”)
//        print(paths)
//        let imageData = UIImageJPEGRepresentation(image!, 0.5) fileManager.createFileAtPath(paths as String, contents: imageData, attributes: nil)
//    }
//    Get Document Directory Path :
//    func getDirectoryPath() -> String {
//        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
//        let documentsDirectory = paths[0] return documentsDirectory
//    }
//    Get Image from Document Directory :
//    func getImage(){
//        let fileManager = NSFileManager.defaultManager()
//        let imagePAth = (self.getDirectoryPath() as NSString).stringByAppendingPathComponent(“apple.jpg”)
//        if fileManager.fileExistsAtPath(imagePAth){
//            self.imageView.image = UIImage(contentsOfFile: imagePAth)
//        }else{
//            print(“No Image”)
//        }
//    }
//    Create Directory :
//    func createDirectory(){
//        let fileManager = NSFileManager.defaultManager()
//        let paths = (NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString).stringByAppendingPathComponent(“customDirectory”)
//        if !fileManager.fileExistsAtPath(paths){
//            try! fileManager.createDirectoryAtPath(paths, withIntermediateDirectories: true, attributes: nil)
//        }else{
//            print(“Already dictionary created.”)
//        }
//    }
//    Delete Directory :
//    func deleteDirectory(){
//        let fileManager = NSFileManager.defaultManager()
//        let paths = (NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString).stringByAppendingPathComponent(“customDirectory”)
//        if fileManager.fileExistsAtPath(paths){
//            try! fileManager.removeItemAtPath(paths)
//        }else{
//            print(“Something wronge.”)
//        }
//    }
}
