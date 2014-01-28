//
//  eventMessage.m
//  WeWrite
//
//  Created by Evan Hsu on 1/28/14.
//  Copyright (c) 2014 EECS 441. All rights reserved.
//

#import "eventMessage.h"
#import "msgStruct.pb.h"
#import <google/protobuf/io/zero_copy_stream_impl_lite.h>
#import <google/protobuf/io/coded_stream.h>

@implementation eventMessage


- (NSData*) formEvent:(int)type eventText:(NSString *)string eventCursor:(double)cursor
{
    msgStruct::TextMsg *text_message = new msgStruct::TextMsg();
    
    switch (type) {
        case 0:
            text_message->set_type(msgStruct::msgType::ADD);
            break;
        case 1:
            text_message->set_type(msgStruct::msgType::DELETE);
            break;
        case 2:
            text_message->set_type(msgStruct::msgType::UNDO);
            break;
        case 3:
            text_message->set_type(msgStruct::msgType::REDO);
            break;
        default:
            break;
    }
    text_message->set_message(std::string([string UTF8String]));
    text_message->set_cursor(cursor);
    
    NSData *return_data = [self getDataForZombie:text_message];
    free(text_message);
    return return_data;
    
}

- (NSMutableDictionary*) retrieveEvent:(NSData *)data
{
    msgStruct::TextMsg *text_message = [self getZombieFromData:data];
    NSMutableDictionary *return_data = [[NSMutableDictionary alloc]init];
    [return_data setObject:[NSString stringWithFormat:@"%s", text_message->message().c_str()]
                    forKey:@"message"];
    [return_data setObject:[NSNumber numberWithInt:((text_message->type() == msgStruct::msgType::ADD)? 0:1)]
                    forKey:@"type"];
    [return_data setObject:[NSNumber numberWithDouble:text_message->cursor()]
                    forKey:@"cursor"];
    free(text_message);
    return return_data;
}

// Serialize to NSData. Note this is convenient because
// we can write NSData to things like sockets...
- (NSData *)getDataForZombie:(msgStruct::TextMsg *)text_message {
    std::string ps = text_message->SerializeAsString();
    return [NSData dataWithBytes:ps.c_str() length:ps.size()];
}

// De-serialize a zombie from an NSData object.
- (msgStruct::TextMsg *)getZombieFromData:(NSData *)data {
    int len = [data length];
    char raw[len];
    msgStruct::TextMsg *text_message = new msgStruct::TextMsg();
    [data getBytes:raw length:len];
    text_message->ParseFromArray(raw, len);
    return text_message;
}


NSData *dataForProtoBufMessage(::google::protobuf::Message &message)
{
    const int bufferLength = message.ByteSize() + ::google::protobuf::io::CodedOutputStream::VarintSize32(message.ByteSize());
    std::vector<char> buffer(bufferLength);
    
    ::google::protobuf::io::ArrayOutputStream arrayOutput(&buffer[0], bufferLength);
    ::google::protobuf::io::CodedOutputStream codedOutput(&arrayOutput);
    
    codedOutput.WriteVarint32(message.ByteSize());
    message.SerializeToCodedStream(&codedOutput);
    
    return [NSData dataWithBytes:&buffer[0] length:bufferLength];
}

NSData *parseDelimitedProtoBufMessageFromData(::google::protobuf::Message &message, NSData *data)
{
    ::google::protobuf::io::ArrayInputStream arrayInputStream([data bytes], [data length]);
    ::google::protobuf::io::CodedInputStream codedInputStream(&arrayInputStream);
    
    uint32_t messageSize;
    codedInputStream.ReadVarint32(&messageSize);
    
    //lets not consume all the data
    codedInputStream.PushLimit(messageSize);
    message.ParseFromCodedStream(&codedInputStream);
    codedInputStream.PopLimit(messageSize);
    
    if ([data length] - codedInputStream.CurrentPosition() > 0)
    {
        return [NSData dataWithBytes:((char *)[data bytes] + codedInputStream.CurrentPosition()) length:[data length] - codedInputStream.CurrentPosition()];
    }
    
    return nil;
}
@end
