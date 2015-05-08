//
//  MessageTableItemAudioDocument.m
//  Telegram
//
//  Created by keepcoder on 17.10.14.
//  Copyright (c) 2014 keepcoder. All rights reserved.
//

#import "MessageTableItemAudioDocument.h"
#import "DownloadDocumentItem.h"
#import "NSStringCategory.h"
#import "NSString+Extended.h"
@implementation MessageTableItemAudioDocument

- (id)initWithObject:(TLMessage *)object {
    self = [super initWithObject:object];
    if(self) {
        self.blockSize = NSMakeSize(200, 60);
        self.duration = self.message.media.document.file_name;
        
       _fileSize = [[NSString sizeToTransformedValuePretty:self.message.media.document.size] trim];
       
        if([self isset])
            self.state = AudioStateWaitPlaying;
        else
            self.state = AudioStateWaitDownloading;
    }
    return self;
}

-(void)checkStartDownload:(SettingsMask)setting size:(int)size {
    [super checkStartDownload:[self.message.to_id isKindOfClass:[TL_peerChat class]] ? AutoGroupDocuments : AutoPrivateDocuments size:[self size]];
}

-(BOOL)canShare {
    return [self isset];
}

-(id)thumbObject {
    return nil;
}


- (Class)downloadClass {
    return [DownloadDocumentItem class];
}

- (BOOL)canDownload {
    return self.message.media.document.dc_id != 0;
}

- (int)size {
    return self.message.media.document.size;
}

-(NSString *)fileName {
    return self.message.media.document.file_name;
}


@end
