//
//  CastMediaStatus.swift
//  OpenCastSwift
//
//  Created by Miles Hollingsworth on 4/22/18
//  Copyright © 2018 Miles Hollingsworth. All rights reserved.
//

import Foundation
import SwiftyJSON

public enum CastMediaPlayerState: String {
  case buffering = "BUFFERING"
  case playing = "PLAYING"
  case paused = "PAUSED"
  case stopped = "STOPPED"
}

public final class CastMediaStatus: NSObject {
  
    public struct MediaStatusMedia {
        public var duration: Double?
        public var contentID: String?
        public let metadata: JSON?
          init?(json: JSON) {
              if let duration = json[CastJSONPayloadKeys.duration].double  {
                self.duration = duration
              }
            if let contentID = json[CastJSONPayloadKeys.contentId].string,
               let data = contentID.data(using: .utf8) {
                self.contentID = (try? JSON(data: data))?[CastJSONPayloadKeys.contentId].string ?? contentID
            }
            self.metadata = json[CastJSONPayloadKeys.metadata]
        }
    }
  public let mediaSessionId: Int
  public let playbackRate: Int
  public let playerState: CastMediaPlayerState
  public let currentTime: Double
  
  private let createdDate = Date()
  
  public let media: MediaStatusMedia?
  public var adjustedCurrentTime: Double {
    return currentTime - Double(playbackRate)*createdDate.timeIntervalSinceNow
  }
  
  public var state: String {
    return playerState.rawValue
  }
  
  public override var description: String {
    return "MediaStatus(mediaSessionId: \(mediaSessionId), playbackRate: \(playbackRate), playerState: \(playerState.rawValue), currentTime: \(currentTime))"
  }
  
  init(json: JSON) {
    mediaSessionId = json[CastJSONPayloadKeys.mediaSessionId].int ?? 0
    
    playbackRate = json[CastJSONPayloadKeys.playbackRate].int ?? 1
    
    playerState = json[CastJSONPayloadKeys.playerState].string.flatMap(CastMediaPlayerState.init) ?? .buffering
    
    currentTime = json[CastJSONPayloadKeys.currentTime].double ?? 0
    
    media = MediaStatusMedia(json: json[CastJSONPayloadKeys.media])
    
    
    super.init()
  }
}
