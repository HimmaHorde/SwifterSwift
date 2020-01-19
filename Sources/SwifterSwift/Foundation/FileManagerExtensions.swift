//
//  FileManagerExtensions.swift
//  SwifterSwift
//
//  Created by Jason Jon E. Carreos on 05/02/2018.
//  Copyright © 2018 SwifterSwift
//

#if canImport(Foundation)
import Foundation

public extension FileManager {

    /// 读取文件并 JSON 解析
    ///
    /// - Parameters:
    ///   - path: JSON 文件路径。
    ///   - options: 解析方式。
    /// - Returns: 返回解析后数据。
    /// - Throws: 抛出解析错误。
    func jsonFromFile(
        atPath path: String,
        readingOptions: JSONSerialization.ReadingOptions = .allowFragments) throws -> [String: Any]? {

        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let json = try JSONSerialization.jsonObject(with: data, options: readingOptions)

        return json as? [String: Any]
    }

    #if !os(Linux)
    /// 读取项目内 JSON 文件并解析
    ///
    /// - Parameters:
    ///   - filename: 要读取的文件.
    ///   - bundleClass: 所在的 Bundle
    ///   - readingOptions: JSON 解析方式
    /// - Returns: 解析结果.
    /// - Throws: 抛出解析异常
    func jsonFromFile(
        withFilename filename: String,
        at bundleClass: AnyClass? = nil,
        readingOptions: JSONSerialization.ReadingOptions = .allowFragments) throws -> [String: Any]? {
        // https://stackoverflow.com/questions/24410881/reading-in-a-json-file-using-swift
        // To handle cases that provided filename has an extension
        let name = filename.components(separatedBy: ".")[0]
        let bundle = bundleClass != nil ? Bundle(for: bundleClass!) : Bundle.main

        if let path = bundle.path(forResource: name, ofType: "json") {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let json = try JSONSerialization.jsonObject(with: data, options: readingOptions)

            return json as? [String: Any]
        }

        return nil
    }
    #endif

    /// 创建用于保存临时文件的唯一目录
    ///
    /// 该目录可用于创建用于公共目的的多个临时文件
    ///
    ///     let tempDirectory = try fileManager.createTemporaryDirectory()
    ///     let tempFile1URL = tempDirectory.appendingPathComponent(ProcessInfo().globallyUniqueString)
    ///     let tempFile2URL = tempDirectory.appendingPathComponent(ProcessInfo().globallyUniqueString)
    ///
    /// - Returns: A URL to a new directory for saving temporary files.
    /// - Throws: An error if a temporary directory cannot be found or created.
    func createTemporaryDirectory() throws -> URL {
        #if !os(Linux)
        let temporaryDirectoryURL: URL
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            temporaryDirectoryURL = temporaryDirectory
        } else {
            temporaryDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
        }

        //.itemReplacementDirectory 用于创建临时目录的常量
        return try url(for: .itemReplacementDirectory,
                       in: .userDomainMask,
                       appropriateFor: temporaryDirectoryURL,
                       create: true)
        #else
        let envs = ProcessInfo.processInfo.environment
        let env = envs["TMPDIR"] ?? envs["TEMP"] ?? envs["TMP"] ?? "/tmp"
        let dir = "/\(env)/file-temp.XXXXXX"
        var template = [UInt8](dir.utf8).map({ Int8($0) }) + [Int8(0)]
        guard mkdtemp(&template) != nil else { throw CocoaError.error(.featureUnsupported) }
        return URL(fileURLWithPath: String(cString: template))
        #endif
    }
}
#endif
