# Lab 3: Storage and Database Services

**Course:** Cloud Computing (SMU)  
**Module:** [3 - S3 and database services](../../modules/03-storage-and-databases/)  
**Author:** Mahindra Guptha Kotha  
**Proof of work:** add the submitted lab PDF to [`proof/`](proof/) (see the note below)

> Screenshots from the original submission are not embedded in this page. The submitted PDF in `proof/` contains them. Account IDs, access keys and passwords have been redacted from the text.

---

EXERCISE 3.1
Create a New S3 Bucket and Upload a File
   1. From the AWS S3 dashboard, create a new bucket and use either the dashboard or the AWS CLI (aws s3 cp mylocalfile.txt s3://mybucketname/) to upload one or more files, giving public read access to the object.
Sign in as a root account.

Select S3 and create a bucket.

   2. Use the AWS CLI to list the contents of your new bucket to confirm that the new file or files are there:
```bash
aws s3 ls s3://mahiawsbucket2345678i
```

EXERCISE 3.2
ENABLE VERSIONING AND LIFE CYCLE MANAGEMENT FOR AN S3 BUCKET

Select your bucket and edit its properties to enable versioning.

Under the bucket versioning and select enable.

Click on save changes.

Upload a file to that bucket, edit the copy on your local computer, and upload the new copy (keeping the filename the same). Make sure you give the new file any access permissions you might need.

With the contents of the bucket displayed in the dashboard, select Show Versions. You should now see two versions of your file.

Add a couple of directories with files to your bucket.

On the bucket's Management tab, create a life cycle rule and specify a prefix/tag filter that matches the directory name of one of the directories you uploaded.

Configure a life cycle rule by adding transitions and configuring the transition timing (in days) and target for each one.

You'll need to be patient to test this configuration because the minimum lag between transitions is 30 days.

EXERCISE 3.3
Generate and Use a Presigned URL
      1. Use the complete URL of a private object in an S3 bucket belonging to you to generate a presigned URL using a variation of this command:
```bash
aws s3 presign s3://privatebucket1233/keerthana.txt --expires-in 600
```

         2. Copy the full URL from the command output, and from a browser that's not logged into your AWS account, try to open the file.

         3. Wait for the URL to expire and try again. This time, it should not work.

EXERCISE 3.4
ENABLE STATIC WEBSITE HOSTING FOR AN S3 BUCKET
From the S3 dashboard, select (or create) an S3 bucket that contains at least one file with some simple text named index.html. Any files you want to be accessible should be readable by the public. You may need to change the Block Public Access settings for the bucket to allow access.

On the bucket's Properties tab, enable static website hosting and specify your index.html file as your index document.

Paste the static website endpoint into the URL field of a browser that's not logged into your AWS account and confirm that you can access the website.

Go to bucket and permission and then bucket policy and add this json code

Note that you can also enable static website hosting from the AWS CLI using a variation of these two commands:

```bash
aws s3api put-bucket-acl --bucket my-bucket --acl public-read
```
```bash
aws s3 website s3://my-bucket/ --index-document index.html\
--error-document error.html
```

EXERCISE 3.5
Calculate the Total Life Cycle Costs for Your Data
Use the AWS Simple Monthly Calculator (http://calculator.s3.amazonaws.com/index.html) to estimate the total monthly costs of the scenario described at the beginning of this section. Even better, use a scenario that fits your own business. Try to include a full usage scenario, including requests, scans, and data retrieval. Note that you access the S3 part of the calculator by clicking the Amazon S3 tab on the left, and you can keep track of your itemized estimate using the Estimate Of Your Monthly Bill tab along the top.

Note that AWS has been trying to deprecate the Simple Monthly Calculator for some time in favor of their new AWS Pricing Calculator (https://calculator.aws/#). However, since so many customers have communicated their preference for the old tool, AWS continues to extend its life. Nevertheless, be aware that the move will likely happen eventually.

Chapter 5
EXERCISE 5.1
Create an RDS Database Instance
In this exercise, you'll create an RDS database instance using MariaDB as the database engine. Free Tier accounts won't incur any charges.
         1. Click the RDS Dashboard link in the RDS service console.

         2. Click Create Database.

         3. Under Choose A Database Creation Method, select Standard Create.

         4. Under Engine Options, select MariaDB. Keep the default version.

         5. Under Templates, select Free Tier.

         6. Enter a master username and master password of your choice.

         7. Scroll down to the Additional Configuration section and expand it.

         8. For Initial Database Name, enter a database name of your choice.

         9. Click Create Database.

Wait for few mins. Then your database would have been created.

EXERCISE 5.2
Create a Read Replica
         1. In the navigation pane of the RDS service console, click Databases.

         2. Select the instance you created earlier, click Actions, and then click Create Read Replica.

         3. Under the Settings section, in the DB Instance Identifier field, enter a name for your read replica.

         4. Click the Create Read Replicas button.

EXERCISE 5.3
PROMOTE THE READ REPLICA TO A MASTER
In this exercise, you'll promote the read replica you just created to master. Before beginning, wait for the replica to enter the Available state.
In the RDS service console, click Databases.

Select the read replica you created.

Click Actions and then select Promote.

Click Continue.

Click Promote Read Replica.

EXERCISE 5.4
CREATE A TABLE IN DYNAMODB USING PROVISIONED MODE

Use the following command to create a table named Authors with a partition key named LastName and sort key named FirstName. Both keys should use the string data type. Provision the table with a WCU and an RCU of 1.

```bash
aws dynamodb create-table ––table-name Authors ––attribute-definitions
```
 AttributeName=LastName,AttributeType=S
 AttributeName=FirstName,AttributeType=S
 ––keyschema AttributeName=LastName,KeyType=HASH
 AttributeName=FirstName,KeyType=RANGE
 ––provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1

Change the region to Ohio because it is standard region by default

Go to the DynamoDB service console to view the table you just created.
