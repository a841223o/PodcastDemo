//
//  EpisodeParser.swift
//  PodcastDemo
//
//  Created by leo on 2022/6/14.
//

import Foundation

class EpisodeParser : NSObject ,XMLParserDelegate {
    
    var isHead = true
    var currentElement = ""
    var xmlData = [String:Any]()
    var xmlDataArray = [[String:Any]]()
    
    var title : String = ""
    var headImageUrl : String = ""
    
    init(data : Data) {
        super.init()
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "item" {
            xmlData = [:]
            isHead = false
        }else{
            currentElement = elementName
        }
        
        if isHead {
            currentElement = elementName
            return
        }
        
        if elementName == "enclosure" {
            var data = [String:Any]()
            data["type"] = attributeDict["type"]
            data["url"] = attributeDict["url"]
            data["length"] = attributeDict["length"]
            xmlData["enclosure"] = data
        }
        
        if elementName == "itunes:image" {
            xmlData["image"] = attributeDict["href"]
        }
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if isHead {
            print(currentElement , string)
            if currentElement == "url" {
                headImageUrl = headImageUrl + " " + string
            }
            if currentElement == "itunes:name" {
                title = title + " " + string
            }
        }
        
        if currentElement == "enclosure" || currentElement == "itunes:image" {
            return
        }
        
        if let value = xmlData[currentElement] {
            xmlData.updateValue(value as! String+" "+string, forKey: currentElement)
        }else{
            xmlData.updateValue(string, forKey: currentElement)
        }
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
            if elementName == "item"{
                xmlDataArray.append(xmlData)
            }
        
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
       
        let model = EpisodeOCModel()
        model.headImageUrl = headImageUrl.trimmingCharacters(in: .whitespacesAndNewlines)
        model.title = title.trimmingCharacters(in: .whitespacesAndNewlines)
        model.items = []
        xmlDataArray.map { data in
            let item = EpisodeOCItem.init(dictionary: data )
            model.items.append(item!)
        }
        
    }
    
}
