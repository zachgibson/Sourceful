//
//  JavaScriptLexer.swift
//  SourceEditor
//
//  Created by Zachary Gibson on 2/15/20.
//  Based on SwiftLexer.swift by Louis D'hauwe.
//  Copyright © 2018 Silver Fox. All rights reserved.
//

import Foundation

public class JavaScriptLexer: SourceCodeRegexLexer {
    
    public init() {
        
    }
    
    lazy var generators: [TokenGenerator] = {
        
        var generators = [TokenGenerator?]()
        
        // Functions
        
        generators.append(regexGenerator("\\b(println|print)(?=\\()", tokenType: .identifier))
        
        generators.append(regexGenerator("(?<=(\\s|\\[|,|:))(\\d|\\.|_)+", tokenType: .number))
        
        generators.append(regexGenerator("\\.[A-Za-z_]+\\w*", tokenType: .identifier))
        
        let keywords = "break case catch class const continue debugger default delete do else export extends finally for function if import in instanceof new return super switch this throw try typeof var void while with yield".components(separatedBy: " ")
        
        generators.append(keywordGenerator(keywords, tokenType: .keyword))
        
        let builtInObjectsIdentifiers = "Infinity NaN undefined null globalThis Object Function Boolean Symbol Error AggregateError  EvalError InternalError  RangeError ReferenceError SyntaxError TypeError URIError Number BigInt Math Date String RegExp Array Int8Array Uint8Array Uint8ClampedArray Int16Array Uint16Array Int32Array Uint32Array Float32Array Float64Array BigInt64Array BigUint64Array Map Set WeakMap WeakSet ArrayBuffer SharedArrayBuffer  Atomics  DataView JSON Promise Generator GeneratorFunction AsyncFunction Iterator  AsyncIterator  Reflect Proxy Intl Intl.Collator Intl.DateTimeFormat Intl.ListFormat Intl.NumberFormat Intl.PluralRules Intl.RelativeTimeFormat Intl.Locale arguments".components(separatedBy: " ")
        
        generators.append(keywordGenerator(builtInObjectsIdentifiers, tokenType: .identifier))
        
        // Line comment
        generators.append(regexGenerator("//(.*)", tokenType: .comment))
        
        // Block comment
        generators.append(regexGenerator("(/\\*)(.*)(\\*/)", options: [.dotMatchesLineSeparators], tokenType: .comment))

        // Single-line string literal
        generators.append(regexGenerator("(\"|@\")[^\"\\n]*(@\"|\")", tokenType: .string))

        return generators.compactMap( { $0 })
    }()
    
    public func generators(source: String) -> [TokenGenerator] {
        return generators
    }
    
}
