using Amazon.Pinpoint;
using Amazon.Pinpoint.Model;
using Amazon.Runtime;
using Amazon.S3;
using Amazon.S3.Model;
using Amazon.SimpleEmail;
using MimeKit;
using System.Collections.Generic;
using System.IO;

namespace AWS4Delphi.Model
{    
    class DadosPinpoint
    {
        public BasicAWSCredentials credentials { get; set; }
        public AmazonPinpointClient client { get; set; }
        public SendMessagesRequest request { get; set; }
        public SendMessagesResponse response { get; set; }
    }

    class InputParametersPinpoint
    {
        public string RegionAWS { get; set; }
        public string AppID { get; set; }        
        public string MessageBody { get; set; }
        public List<string> RecipientList { get; set; }        
    }    

    class DadosS3
    {
        public IAmazonS3 s3 { get; set; }
        public AmazonS3Client client { get; set; }
        public PutObjectRequest request { get; set; }
        public PutObjectResponse response { get; set; }
        public InitiateMultipartUploadRequest uploadRequest { get; set; }
        public InputParametersS3 inputParameters { get; set; }
        public string result { get; set; }
    }

    class InputParametersS3
    {
        public string RegionAWS { get; set; }
        public string BucketName { get; set; }        
        public string FilePath { get; set; }
    }

    class DadosEmailSimple
    {
        public AmazonSimpleEmailServiceClient client { get; set; }
        public Amazon.SimpleEmail.Model.Destination destination { get; set; }
        public Amazon.SimpleEmail.Model.Message message { get; set; }
        public Amazon.SimpleEmail.Model.Body body { get; set; }
        public Amazon.SimpleEmail.Model.Content content { get; set; }
        public Amazon.SimpleEmail.Model.Content contentAux { get; set; }
        public Amazon.SimpleEmail.Model.SendEmailRequest request { get; set; }
        public Amazon.SimpleEmail.Model.SendEmailResponse response { get; set; }
        public string result { get; set; }
    }

    class DadosEmail
    {
        public AmazonSimpleEmailServiceClient client { get; set; }
        public Amazon.SimpleEmail.Model.SendRawEmailRequest request { get; set; }
        public AmazonWebServiceResponse response { get; set; }        
        public BodyBuilder bodyBuilder { get; set; }
        public MemoryStream fileAttach { get; set; }
        public MimeMessage mimeMessage { get; set; }
        public MemoryStream messageStream { get; set; }
        public Amazon.SimpleEmail.Model.RawMessage rawMessage { get; set; }
        public string result { get; set; }
    }

    class InputParametersEmail
    {
        public string RegionAWS { get; set; }
        public string EmailSender { get; set; }
        public string Subject { get; set; }
        public string MessageBody { get; set; }
        public List<string> RecipientList { get; set; }
        public List<string> FilePathList { get; set; }
    }


}

