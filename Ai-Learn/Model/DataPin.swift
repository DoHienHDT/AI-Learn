//
//  DataPin.swift
//  Ai-Learn
//
//  Created by vmio vmio on 12/27/19.
//  Copyright © 2019 VmioSystem. All rights reserved.
//

import Alamofire

let dataLocationDropbox: Parameters = [
    
    "data": [
        //1 WebView
        ["name": "S1 大阪ドーム",
         "lat": 21.029466,
         "long":105.780149,
         "url": "https://www.dropbox.com/s/nl2ft5rnaplkjsm/%E2%91%A2%E6%A9%8B%E6%A2%81.mp4?dl=0",
         "image": "pin01",
         "idPin":"1"
        ],
        
        //2 WebView
        ["name": "S2 なんばHatch",
         "lat": 34.6679649,
         "long":135.4953228,
         "url": "https://ja.wikipedia.org/wiki/%E6%B9%8A%E7%94%BA%E3%83%AA%E3%83%90%E3%83%BC%E3%83%97%E3%83%AC%E3%82%A4%E3%82%B9",
         "image": "pin01",
         "idPin":"2"
        ],
        
        //3 Video
        ["name": "S3 高速",
         "lat": 34.6680171,
         "long":135.4948785,
         "url": "https://www.dropbox.com/s/nl2ft5rnaplkjsm/%E2%91%A2%E6%A9%8B%E6%A2%81.mp4?dl=0",
         "image": "pin01",
         "idPin":"3"
        ],
        
        //4 PDF
        ["name": "S4 工事記録（コンクリート",
         "lat": 34.6679227,
         "long":135.4876619,
         "url": "https://www.dropbox.com/s/aamcgnncpofjz57/%E2%91%A1%E8%87%AA%E7%84%B6%E6%96%9C%E9%9D%A2.mp4?dl=0",
         "image":"pin02",
         "idPin":"4"
        ],
        
        //5 Video
        ["name": "S5 工事記録",
         "lat": 34.6706435,
         "long":135.486175,
         "url": "https://www.dropbox.com/s/7ti8v021kkgqy06/S5%20%E5%B7%A5%E4%BA%8B%E8%A8%98%E9%8C%B2.mp4?dl=0",
         "image":"pin04",
         "idPin":"5"
        ],
        
        //6 PDF
        ["name": "S6 工事記録（鉄筋)",
         "lat": 34.6658686,
         "long":135.4842081,
         "url": "https://www.dropbox.com/s/zfe2e2uwrwcrasz/S6%20%E5%8E%9F%E7%A8%BF%28%E9%89%84%E7%AD%8B%E5%B7%A5%EF%BC%89.pdf?dl=0",
         "image":"pin02",
         "idPin":"6"
        ],
        
        //7 PDF
        ["name":"S7 工事計画書",
         "lat": 34.6641377,
         "long":135.4878459,
         "url": "https://www.dropbox.com/s/pupko53krdrm6yl/S7%20%E3%82%B3%E3%83%B3%E3%82%AF%E3%83%AA%E3%83%BC%E3%83%88%E5%AE%9F%E6%96%BD%E6%9B%B8%EF%BC%88%EF%BC%B0%EF%BC%B5%EF%BC%95%E5%BA%95%E7%89%88%EF%BC%89.pdf?dl=0",
         "image":"pin04",
         "idPin":"7"
        ],
        
        //8 Video
        ["name": "S8 道頓堀川",
         "lat": 34.6690171,
         "long":135.4873277,
         "url": "https://www.dropbox.com/s/l5krv6mxxxwqzl6/%E2%91%A0%E6%B2%B3%E5%B7%9D%E6%A7%8B%E9%80%A0%E7%89%A9.mp4?dl=0",
         "image":"pin05",
         "idPin":"8"
        ],
        
        //9 PDF
        ["name": "S9 淀川",
         "lat": 34.6697723,
         "long":135.4555488,
         "url": "https://www.dropbox.com/s/i8cx4i2vc9fio7k/S9%20%E7%A0%82%E9%98%B2%E8%A1%8C%E6%94%BF%E3%81%AB%E9%96%A2%E3%81%99%E3%82%8B%E6%9C%80%E8%BF%91%E3%81%AE%E8%A9%B1%E9%A1%8C.pdf?dl=0",
         "image":"pin02",
         "idPin":"9"
        ],
        
        //10 PDF
        ["name": "S10 歴史資料",
         "lat": 34.6671167,
         "long":135.4955264,
         "url": "https://www.dropbox.com/s/l8t9woic30urtev/S10%20%E8%A8%98%E4%BA%8B%E3%80%80%E7%94%B0%E9%82%89%E6%9C%94%E9%83%8E.pdf?dl=0",
         "image":"pin05",
         "idPin":"10"
        ],
        
        //11 PDF
        ["name": "S11 工事広報",
         "lat": 34.6671167,
         "long":135.4955264,
         "url": "https://www.dropbox.com/s/k1gpxle0x2zwsll/S11%20%E5%BA%83%E5%A0%B1%E7%B4%99%EF%BC%88vol.12%EF%BC%89.pdf?dl=0",
         "image":"pin04",
         "idPin":"11"
        ],
        
        ["name": "T1 ゆりかもめ",
         "lat": 35.6404677,
         "long":139.7645922,
         "url": "https://www.navitime.co.jp/railroad/00000239/%E3%82%86%E3%82%8A%E3%81%8B%E3%82%82%E3%82%81",
         "image":"pin01",
         "idPin":"12"
        ],
        
        ["name": "T2 工事数量",
         "lat": 35.6416793,
         "long":139.7608308,
         "url": "https://www.dropbox.com/s/js0u932ar3zb3v7/sample_Asanuma_20191226_01.pdf?dl=0",
         "image":"pin01",
         "idPin":"13"
        ],
        
        ["name": "T3 潮路橋",
         "lat": 35.6419453,
         "long":139.7553968,
         "url": "https://www.dropbox.com/s/qvfaoo0el7s8x06/T3.mp4?dl=0",
         "image":"pin01",
         "idPin":"14"
        ],
        
        ["name": "T4 浦島橋",
         "lat": 35.6435748,
         "long":139.7554148,
         "url": "https://www.dropbox.com/s/qnuronm3zxvr6oc/T4.mp4?dl=0",
         "image":"pin02",
         "idPin":"15"
        ],
        
        ["name": "T5 河川点検",
         "lat": 35.6427943,
         "long":139.7543009,
         "url": "https://www.dropbox.com/s/vbfu8858eliso59/T5.mp4?dl=0",
         "image":"pin04",
         "idPin":"16"
        ],
        
        ["name": "T6 河川点検",
         "lat": 35.6449370,
         "long":139.7539736,
         "url": "https://www.dropbox.com/s/yhj8rie1btj9uc6/T6_Ai-LEARN.mp4?dl=0",
         "image":"pin02",
         "idPin":"17"
        ],
        
        ["name": "T7 芝浦ふ頭",
         "lat": 35.6435981,
         "long":139.7589268,
         "url": "https://www.dropbox.com/s/dzaodpj4hpysvj1/T7%20%E3%82%B8%E3%82%AA%E3%83%A9%E3%83%9E%E3%83%A2%E3%83%87%E3%83%AB.mp4?dl=0",
         "image":"pin04",
         "idPin":"18"
        ],
        
        ["name": "T8 晴海ふ頭",
         "lat": 35.6445994,
         "long":139.7540669,
         "url": "https://www.dropbox.com/s/n5oxf19wejut5zm/T8%20%E7%A0%82%E9%98%B2%E8%A1%8C%E6%94%BF%E3%81%AB%E9%96%A2%E3%81%99%E3%82%8B%E6%9C%80%E8%BF%91%E3%81%AE%E8%A9%B1%E9%A1%8C.pdf?dl=0",
         "image":"pin04",
         "idPin":"19"
        ],
        
        // Jingu
        ["name": "Ｊ１鹿島神宮",
         "lat": 35.9657919,
         "long":140.6186959,
         "url": "https://ja.wikipedia.org/wiki/%E9%B9%BF%E5%B3%B6%E7%A5%9E%E5%AE%AE",
         "image":"pin04",
         "idPin":"20"
        ],
        ["name": "Ｊ２アサザ",
         "lat": 35.9648368,
         "long":140.6099798,
         "url": "https://ja.wikipedia.org/wiki/%E3%82%A2%E3%82%B5%E3%82%B6",
         "image":"pin06",
         "idPin":"21"
        ],
        ["name": "Ｊ３鹿島工業地帯",
         "lat": 35.9549826,
         "long":140.6407112,
         "url": "https://ja.wikipedia.org/wiki/%E9%B9%BF%E5%B3%B6%E8%87%A8%E6%B5%B7%E5%B7%A5%E6%A5%AD%E5%9C%B0%E5%B8%AF",
         "image":"pin01",
         "idPin":"22"
        ],
        ["name": "Ｊ４工事記録（コンクリート）",
         "lat": 35.9648166,
         "long":140.6097244,
         "url": "https://www.dropbox.com/s/mn3hn24i1m30355/S4%20%E5%8E%9F%E7%A8%BF%EF%BC%88%E5%9E%8B%E6%9E%A0%E5%B7%A5%EF%BC%89.pdf?dl=0",
         "image":"pin02",
         "idPin":"23"
        ],
        ["name": "Ｊ５工事記録",
         "lat": 35.9600617,
         "long":140.6005761,
         "url": "https://www.dropbox.com/s/vbfu8858eliso59/T5.mp4?dl=0",
         "image":"pin05",
         "idPin":"24"
        ],
        ["name": "Ｊ６工事記録（鉄筋",
         "lat": 35.9647895,
         "long":140.6098194,
         "url": "https://www.dropbox.com/s/yhj8rie1btj9uc6/T6_Ai-LEARN.mp4?dl=0",
         "image":"pin04",
         "idPin":"25"
        ],
        ["name": "Ｊ７北浦",
         "lat": 35.9839416,
         "long":140.5631841,
         "url": "https://anglers.jp/areas/559",
         "image":"pin05",
         "idPin":"26"
        ],
        ["name": "Ｊ８河川点検",
         "lat": 35.9172962,
         "long":140.5879139,
         "url": "https://www.dropbox.com/s/l5krv6mxxxwqzl6/%E2%91%A0%E6%B2%B3%E5%B7%9D%E6%A7%8B%E9%80%A0%E7%89%A9.mp4?dl=0",
         "image":"pin02",
         "idPin":"27"
        ],
        ["name": "Ｊ９高速",
         "lat": 35.9585862,
         "long":140.5983698,
         "url": "https://www.dropbox.com/s/i8cx4i2vc9fio7k/S9%20%E7%A0%82%E9%98%B2%E8%A1%8C%E6%94%BF%E3%81%AB%E9%96%A2%E3%81%99%E3%82%8B%E6%9C%80%E8%BF%91%E3%81%AE%E8%A9%B1%E9%A1%8C.pdf?dl=0",
         "image":"pin01",
         "idPin":"28"
        ],
        ["name": "Ｊ１０ 霞ヶ浦",
         "lat": 36.0178454,
         "long":140.456426,
         "url": "https://ja.wikipedia.org/wiki/%E9%9C%9E%E3%83%B6%E6%B5%A6",
         "image":"pin06",
         "idPin":"29"
        ],
        ["name": "Ｊ１１淺沼組",
         "lat": 35.9653282,
         "long":140.6105854,
         "url": "https://www.dropbox.com/s/k1gpxle0x2zwsll/S11%20%E5%BA%83%E5%A0%B1%E7%B4%99%EF%BC%88vol.12%EF%BC%89.pdf?dl=0",
         "image":"pin04",
         "idPin":"30"
        ]
    ]
]

