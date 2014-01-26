// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: msgStruct.proto

#ifndef PROTOBUF_msgStruct_2eproto__INCLUDED
#define PROTOBUF_msgStruct_2eproto__INCLUDED

#include <string>

#include <google/protobuf/stubs/common.h>

#if GOOGLE_PROTOBUF_VERSION < 2005000
#error This file was generated by a newer version of protoc which is
#error incompatible with your Protocol Buffer headers.  Please update
#error your headers.
#endif
#if 2005000 < GOOGLE_PROTOBUF_MIN_PROTOC_VERSION
#error This file was generated by an older version of protoc which is
#error incompatible with your Protocol Buffer headers.  Please
#error regenerate this file with a newer version of protoc.
#endif

#include <google/protobuf/generated_message_util.h>
#include <google/protobuf/message.h>
#include <google/protobuf/repeated_field.h>
#include <google/protobuf/extension_set.h>
#include <google/protobuf/generated_enum_reflection.h>
#include <google/protobuf/unknown_field_set.h>
// @@protoc_insertion_point(includes)

namespace msgStruct {

// Internal implementation detail -- do not call these.
void  protobuf_AddDesc_msgStruct_2eproto();
void protobuf_AssignDesc_msgStruct_2eproto();
void protobuf_ShutdownFile_msgStruct_2eproto();

class TextMsg;

enum msgType {
  ADD = 0,
  DELETE = 1,
  UNDO = 2,
  REDO = 3
};
bool msgType_IsValid(int value);
const msgType msgType_MIN = ADD;
const msgType msgType_MAX = REDO;
const int msgType_ARRAYSIZE = msgType_MAX + 1;

const ::google::protobuf::EnumDescriptor* msgType_descriptor();
inline const ::std::string& msgType_Name(msgType value) {
  return ::google::protobuf::internal::NameOfEnum(
    msgType_descriptor(), value);
}
inline bool msgType_Parse(
    const ::std::string& name, msgType* value) {
  return ::google::protobuf::internal::ParseNamedEnum<msgType>(
    msgType_descriptor(), name, value);
}
// ===================================================================

class TextMsg : public ::google::protobuf::Message {
 public:
  TextMsg();
  virtual ~TextMsg();

  TextMsg(const TextMsg& from);

  inline TextMsg& operator=(const TextMsg& from) {
    CopyFrom(from);
    return *this;
  }

  inline const ::google::protobuf::UnknownFieldSet& unknown_fields() const {
    return _unknown_fields_;
  }

  inline ::google::protobuf::UnknownFieldSet* mutable_unknown_fields() {
    return &_unknown_fields_;
  }

  static const ::google::protobuf::Descriptor* descriptor();
  static const TextMsg& default_instance();

  void Swap(TextMsg* other);

  // implements Message ----------------------------------------------

  TextMsg* New() const;
  void CopyFrom(const ::google::protobuf::Message& from);
  void MergeFrom(const ::google::protobuf::Message& from);
  void CopyFrom(const TextMsg& from);
  void MergeFrom(const TextMsg& from);
  void Clear();
  bool IsInitialized() const;

  int ByteSize() const;
  bool MergePartialFromCodedStream(
      ::google::protobuf::io::CodedInputStream* input);
  void SerializeWithCachedSizes(
      ::google::protobuf::io::CodedOutputStream* output) const;
  ::google::protobuf::uint8* SerializeWithCachedSizesToArray(::google::protobuf::uint8* output) const;
  int GetCachedSize() const { return _cached_size_; }
  private:
  void SharedCtor();
  void SharedDtor();
  void SetCachedSize(int size) const;
  public:

  ::google::protobuf::Metadata GetMetadata() const;

  // nested types ----------------------------------------------------

  // accessors -------------------------------------------------------

  // required .msgStruct.msgType type = 1 [default = ADD];
  inline bool has_type() const;
  inline void clear_type();
  static const int kTypeFieldNumber = 1;
  inline ::msgStruct::msgType type() const;
  inline void set_type(::msgStruct::msgType value);

  // optional string message = 2;
  inline bool has_message() const;
  inline void clear_message();
  static const int kMessageFieldNumber = 2;
  inline const ::std::string& message() const;
  inline void set_message(const ::std::string& value);
  inline void set_message(const char* value);
  inline void set_message(const char* value, size_t size);
  inline ::std::string* mutable_message();
  inline ::std::string* release_message();
  inline void set_allocated_message(::std::string* message);

  // required double longitude = 3;
  inline bool has_longitude() const;
  inline void clear_longitude();
  static const int kLongitudeFieldNumber = 3;
  inline double longitude() const;
  inline void set_longitude(double value);

  // @@protoc_insertion_point(class_scope:msgStruct.TextMsg)
 private:
  inline void set_has_type();
  inline void clear_has_type();
  inline void set_has_message();
  inline void clear_has_message();
  inline void set_has_longitude();
  inline void clear_has_longitude();

  ::google::protobuf::UnknownFieldSet _unknown_fields_;

  ::std::string* message_;
  double longitude_;
  int type_;

  mutable int _cached_size_;
  ::google::protobuf::uint32 _has_bits_[(3 + 31) / 32];

  friend void  protobuf_AddDesc_msgStruct_2eproto();
  friend void protobuf_AssignDesc_msgStruct_2eproto();
  friend void protobuf_ShutdownFile_msgStruct_2eproto();

  void InitAsDefaultInstance();
  static TextMsg* default_instance_;
};
// ===================================================================


// ===================================================================

// TextMsg

// required .msgStruct.msgType type = 1 [default = ADD];
inline bool TextMsg::has_type() const {
  return (_has_bits_[0] & 0x00000001u) != 0;
}
inline void TextMsg::set_has_type() {
  _has_bits_[0] |= 0x00000001u;
}
inline void TextMsg::clear_has_type() {
  _has_bits_[0] &= ~0x00000001u;
}
inline void TextMsg::clear_type() {
  type_ = 0;
  clear_has_type();
}
inline ::msgStruct::msgType TextMsg::type() const {
  return static_cast< ::msgStruct::msgType >(type_);
}
inline void TextMsg::set_type(::msgStruct::msgType value) {
  assert(::msgStruct::msgType_IsValid(value));
  set_has_type();
  type_ = value;
}

// optional string message = 2;
inline bool TextMsg::has_message() const {
  return (_has_bits_[0] & 0x00000002u) != 0;
}
inline void TextMsg::set_has_message() {
  _has_bits_[0] |= 0x00000002u;
}
inline void TextMsg::clear_has_message() {
  _has_bits_[0] &= ~0x00000002u;
}
inline void TextMsg::clear_message() {
  if (message_ != &::google::protobuf::internal::kEmptyString) {
    message_->clear();
  }
  clear_has_message();
}
inline const ::std::string& TextMsg::message() const {
  return *message_;
}
inline void TextMsg::set_message(const ::std::string& value) {
  set_has_message();
  if (message_ == &::google::protobuf::internal::kEmptyString) {
    message_ = new ::std::string;
  }
  message_->assign(value);
}
inline void TextMsg::set_message(const char* value) {
  set_has_message();
  if (message_ == &::google::protobuf::internal::kEmptyString) {
    message_ = new ::std::string;
  }
  message_->assign(value);
}
inline void TextMsg::set_message(const char* value, size_t size) {
  set_has_message();
  if (message_ == &::google::protobuf::internal::kEmptyString) {
    message_ = new ::std::string;
  }
  message_->assign(reinterpret_cast<const char*>(value), size);
}
inline ::std::string* TextMsg::mutable_message() {
  set_has_message();
  if (message_ == &::google::protobuf::internal::kEmptyString) {
    message_ = new ::std::string;
  }
  return message_;
}
inline ::std::string* TextMsg::release_message() {
  clear_has_message();
  if (message_ == &::google::protobuf::internal::kEmptyString) {
    return NULL;
  } else {
    ::std::string* temp = message_;
    message_ = const_cast< ::std::string*>(&::google::protobuf::internal::kEmptyString);
    return temp;
  }
}
inline void TextMsg::set_allocated_message(::std::string* message) {
  if (message_ != &::google::protobuf::internal::kEmptyString) {
    delete message_;
  }
  if (message) {
    set_has_message();
    message_ = message;
  } else {
    clear_has_message();
    message_ = const_cast< ::std::string*>(&::google::protobuf::internal::kEmptyString);
  }
}

// required double longitude = 3;
inline bool TextMsg::has_longitude() const {
  return (_has_bits_[0] & 0x00000004u) != 0;
}
inline void TextMsg::set_has_longitude() {
  _has_bits_[0] |= 0x00000004u;
}
inline void TextMsg::clear_has_longitude() {
  _has_bits_[0] &= ~0x00000004u;
}
inline void TextMsg::clear_longitude() {
  longitude_ = 0;
  clear_has_longitude();
}
inline double TextMsg::longitude() const {
  return longitude_;
}
inline void TextMsg::set_longitude(double value) {
  set_has_longitude();
  longitude_ = value;
}


// @@protoc_insertion_point(namespace_scope)

}  // namespace msgStruct

#ifndef SWIG
namespace google {
namespace protobuf {

template <>
inline const EnumDescriptor* GetEnumDescriptor< ::msgStruct::msgType>() {
  return ::msgStruct::msgType_descriptor();
}

}  // namespace google
}  // namespace protobuf
#endif  // SWIG

// @@protoc_insertion_point(global_scope)

#endif  // PROTOBUF_msgStruct_2eproto__INCLUDED