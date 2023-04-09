unit AWS4Delphi.Model.S3;

interface

uses
  System.JSON;

type
  TS3 = class
    private
      FRegionAWS: String;
      FBucketName: String;
      FFilePath: String;

      FJSON: TJSONObject;
    public
      constructor Create;
      destructor Destroy; override;

      function JSONParameters: String;

      property RegionAWS: String  read FRegionAWS  write FRegionAWS;
      property BucketName: String read FBucketName write FBucketName;
      property FilePath: String   read FFilePath   write FFilePath;
  end;

implementation

uses
  System.SysUtils;

{ TS3 }

constructor TS3.Create;
begin
  FJSON := TJSONObject.Create;
end;

destructor TS3.Destroy;
begin
  FreeAndNil(FJSON);
  inherited;
end;

function TS3.JSONParameters: String;
begin
  FJSON.AddPair('RegionAWS', FRegionAWS);
  FJSON.AddPair('BucketName', FBucketName);
  FJSON.AddPair('FilePath', FFilePath);

  Result := FJSON.ToJSON;
end;

end.
