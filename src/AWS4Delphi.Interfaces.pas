unit AWS4Delphi.Interfaces;

interface

uses
  System.Classes;

type
  ISendSMS = interface
    ['{BC419BAC-64CA-4749-946D-6F00C48950BD}']
    function SetMessage(const aMessage: String): ISendSMS;
    function SetPhoneNumber(const aNumber: String): ISendSMS; overload;
    function SetPhoneNumber(const aNumber: TStrings): ISendSMS; overload;
    function SetRegion(const aRegion: String): ISendSMS;
    function SetAppId(const aAppId: String): ISendSMS;

    procedure ValidatedPhoneNumber(const aNumber: String);
    procedure SendSMS(var aResult: String);
  end;

  ISendS3 = interface
    ['{9CC6F3D0-655A-4C4C-8559-17CA2B65395A}']
    function SetFilePath(const aFilePath: String): ISendS3;
    function SetRegion(const aRegion: String): ISendS3;
    function SetBucketName(const aBucketName: String): ISendS3;

    procedure SendFile(var aResult: String);
    procedure SendFileMP(var aResult: String);
  end;

  ISendEmail = interface
    ['{7ED4A5CE-C708-4D23-8A1E-01A7802A06B2}']
    function SetRegion(const aRegion: String): ISendEmail;
    function SetEmailSender(const aEmail: String): ISendEmail;
    function SetSubject(const aSubject: String): ISendEmail;
    function SetMessageBody(const aMessage: String): ISendEmail;
    function SetRecipient(const aRecipient: String): ISendEmail; overload;
    function SetRecipient(const aRecipient: TStrings): ISendEmail; overload;
    function SetFilePath(const aFilePath: String): ISendEmail; overload;
    function SetFilePath(const aFilePath: TStrings): ISendEmail; overload;

    procedure SendEmail(var aResult: String);
    procedure SendEmailWithFile(var aResult: String);
  end;

implementation

end.
