unit AWS4Delphi.Model.SMS;

interface

uses
  System.JSON,
  System.Generics.Collections;

type
  TSMS = class
    private
      FRegionAWS: String;
      FAppID: String;
      FMessageBody: String;
      FRecipientList: TList<String>;

      FJSON: TJSONObject;
    public
      constructor Create;
      destructor Destroy; override;

      procedure AddPhoneNumber(const aPhoneNumber: String);
      function JSONParameters: String;

      property RegionAWS: String   read FRegionAWS   write FRegionAWS;
      property AppID: String       read FAppID       write FAppID;
      property MessageBody: String read FMessageBody write FMessageBody;
  end;

implementation

uses
  System.SysUtils;

{ TSMS }

procedure TSMS.AddPhoneNumber(const aPhoneNumber: String);
begin
  FRecipientList.Add(aPhoneNumber);
end;

constructor TSMS.Create;
begin
  FJSON := TJSONObject.Create;
  FRecipientList := TList<String>.Create;
end;

destructor TSMS.Destroy;
begin
  FreeAndNil(FJSON);
  FreeAndNil(FRecipientList);
  inherited;
end;

function TSMS.JSONParameters: String;
var
  xRecipientList: TJSONArray;
  xRecipient: String;
begin
  FJSON.AddPair('RegionAWS', FRegionAWS);
  FJSON.AddPair('AppID', FAppID);
  FJSON.AddPair('MessageBody', FMessageBody);

  xRecipientList := TJSONArray.Create;
  for xRecipient in FRecipientList do
    xRecipientList.Add(xRecipient);

  FJSON.AddPair('RecipientList', xRecipientList);

  Result := FJSON.ToJSON;
end;

end.
