using Amazon;
using AWS4Delphi.Model;
using MimeKit;
using System;
using System.IO;
using Newtonsoft.Json;

namespace AWS4Delphi.Email
{
    class ServiceEmail
    {
        public static string SendEmail(string aJSONParameters)
        {
            try
            {
                //Environment Variables
                string xAccessToken = Environment.GetEnvironmentVariable("TOKEN_AWS", EnvironmentVariableTarget.User);
                string xSecretToken = Environment.GetEnvironmentVariable("SECRET_AWS", EnvironmentVariableTarget.User);
                                                                
                InputParametersEmail inputParametersEmail = JsonConvert.DeserializeObject<InputParametersEmail>(aJSONParameters);

                DadosEmailSimple dadosEmailSimple = new DadosEmailSimple();
                var awsCredentials = new Amazon.Runtime.BasicAWSCredentials(xAccessToken, xSecretToken);
                dadosEmailSimple.client = new Amazon.SimpleEmail.AmazonSimpleEmailServiceClient(awsCredentials, RegionEndpoint.GetBySystemName(inputParametersEmail.RegionAWS));

                dadosEmailSimple.destination = new Amazon.SimpleEmail.Model.Destination();

                foreach (string recipient in inputParametersEmail.RecipientList) {
                    dadosEmailSimple.destination.ToAddresses.Add(recipient);
                }                

                dadosEmailSimple.message = new Amazon.SimpleEmail.Model.Message();
                dadosEmailSimple.body = new Amazon.SimpleEmail.Model.Body();
                dadosEmailSimple.content = new Amazon.SimpleEmail.Model.Content();

                //Message Body
                dadosEmailSimple.content.Data = inputParametersEmail.MessageBody;
                dadosEmailSimple.body.Text = dadosEmailSimple.content;
                dadosEmailSimple.message.Body = dadosEmailSimple.body;

                //Subject
                dadosEmailSimple.contentAux = new Amazon.SimpleEmail.Model.Content();
                dadosEmailSimple.contentAux.Data = inputParametersEmail.Subject;
                dadosEmailSimple.message.Subject = dadosEmailSimple.contentAux;

                dadosEmailSimple.request = new Amazon.SimpleEmail.Model.SendEmailRequest(
                    inputParametersEmail.EmailSender,
                    dadosEmailSimple.destination,
                    dadosEmailSimple.message);

                dadosEmailSimple.response = dadosEmailSimple.client.SendEmail(dadosEmailSimple.request);
                dadosEmailSimple.result = dadosEmailSimple.response.HttpStatusCode.ToString();
            
                return dadosEmailSimple.result;
            }
            catch (Exception e)
            {
                return e.Message;
            }
        }

        public static string SendEmailWithFile(string aJSONParameters)
        {
            try
            {
                //Environment Variables
                string xAccessToken = Environment.GetEnvironmentVariable("TOKEN_AWS", EnvironmentVariableTarget.User);
                string xSecretToken = Environment.GetEnvironmentVariable("SECRET_AWS", EnvironmentVariableTarget.User);                

                InputParametersEmail inputParametersEmail = JsonConvert.DeserializeObject<InputParametersEmail>(aJSONParameters);

                DadosEmail dadosEmail = new DadosEmail();
                var awsCredentials = new Amazon.Runtime.BasicAWSCredentials(xAccessToken, xSecretToken);
                dadosEmail.client  = new Amazon.SimpleEmail.AmazonSimpleEmailServiceClient(awsCredentials, RegionEndpoint.GetBySystemName(inputParametersEmail.RegionAWS));
                
                dadosEmail.bodyBuilder = new MimeKit.BodyBuilder()
                {
                    HtmlBody = inputParametersEmail.MessageBody,
                    TextBody = inputParametersEmail.MessageBody
                };

                //Attachments                
                foreach (string file in inputParametersEmail.FilePathList)
                {
                    string fileName = Path.GetFileName(file);
                    string extName = Path.GetExtension(file);
                    
                    dadosEmail.fileAttach = new MemoryStream();

                    ReadIntoMemoryStream(dadosEmail.fileAttach, file);
                    dadosEmail.fileAttach.Seek(0, System.IO.SeekOrigin.Begin);
                    dadosEmail.bodyBuilder.Attachments.Add(fileName, dadosEmail.fileAttach, new ContentType("application", extName));
                }                

                //Stakeholders
                dadosEmail.mimeMessage = new MimeMessage();
                dadosEmail.mimeMessage.From.Add(new MailboxAddress("", inputParametersEmail.EmailSender));
                
                foreach (string recipient in inputParametersEmail.RecipientList)
                {
                    dadosEmail.mimeMessage.To.Add(new MailboxAddress("", recipient));
                }                
                
                dadosEmail.mimeMessage.Subject = inputParametersEmail.Subject;
                dadosEmail.mimeMessage.Body = dadosEmail.bodyBuilder.ToMessageBody();

                //Message
                dadosEmail.messageStream = new MemoryStream();
                dadosEmail.mimeMessage.WriteToAsync(dadosEmail.messageStream);

                dadosEmail.rawMessage = new Amazon.SimpleEmail.Model.RawMessage(dadosEmail.messageStream);
                dadosEmail.request = new Amazon.SimpleEmail.Model.SendRawEmailRequest(dadosEmail.rawMessage);

                dadosEmail.response = dadosEmail.client.SendRawEmail(dadosEmail.request);
                dadosEmail.result = dadosEmail.response.HttpStatusCode.ToString();

                return dadosEmail.result;
            }
            catch (Exception e)
            {
                return e.Message;
            }
        }

        private static void ReadIntoMemoryStream(MemoryStream memoryStream, string filePath)
        {
            byte[] fileContents = File.ReadAllBytes(filePath);
            memoryStream.Write(fileContents, 0, fileContents.Length);
        }
    }
}
