# Lab 1: Identity and Access Management

**Course:** Cloud Computing (SMU)  
**Module:** [1 - AWS IAM](../../modules/01-iam/)  
**Author:** Mahindra Guptha Kotha  
**Proof of work:** add the submitted lab PDF to [`proof/`](proof/) (see the note below)

> Screenshots from the original submission are not embedded in this page. The submitted PDF in `proof/` contains them. Account IDs, access keys and passwords have been redacted from the text.

---

Ex 6:
6.1. Lock Down the root user in AWS
1. Creating a Regular user and assign admin access policy

Login to AWS using root user. Navigate to Services → security, identity and compliance → IAM.

Click User → Create user.
Give username and password (custom)

Click Next. Select attach policies and select ‘Administratoraccess’ under permission policies.

Review the user details

Click Create user. After that save sign in URL.

2. Make sure there are no active access keys associated with your root account.
Remove no active access keys

3. Enable MFA for the root account, where short-lived authentication codes are sent to applications on preset mobile devices (including smartphones) to confirm a user's identity
In the IAM Dashboard. Click Add MFA → choose virtual MFA and activate MFA. Then Activate the MFA.

4. Update your root login to a password that's long and complex and that includes non alphanumeric characters.
Under your root profile select security credentials → edit user, mail and password.

Under the account details click edit → password.
Change the password based on the AWS recommendation.

5. Confirm that you can still log in as root and then store the password safely.
Login with your new password.

Ex 6.2 - Assign and implement an IAM Dashboard
1. Create a new user in the IAM Dashboard.
Create a user under IAM.

2. Attach the AmazonS3FullAccess policy that will permit your user to create, edit, and delete S3 buckets. (Hint: You can search IAM policies using s3 to display a much shorter list.)

3. Note the user login instructions that will be displayed.
Review the create user details and then click create user. Copy the user sign in URL.

4. Log in as your new user and try creating a new S3 bucket.

5. Just to prove everything is working, try launching an EC2 instance. Your request should be denied.

Ex 6.3 - Create, use and delete an AWS access key
1. Create a new AWS access key, and save both the access key ID and secret access key somewhere secure.
In the AWS console search for IAM and navigate to users

Click on the user for the details of the user and then select security credentials.

2. Enter aws configure at your local command line to add the key to your AWS CLI configuration.
Scroll down and click on the create access key and select Command line interface option.

Click Next and Create access key. Save the access key

3. Try performing some operation—such as listing your S3 buckets—and then uploading a local file using the AWS CLI and your new key.
In the AWS Management console search for S3 using root user.

Click create bucket.

You can see the newly created bucket.

4. In the console, disable (select Make Inactive) or delete the key you just created from the IAM Dashboard.
In the IAM → users → Select the user that you created the access key.

On access key → action → deactivate

5. Confirm that you are now unable to administer your S3 buckets using the key.

Ex 6.4 - Create and configure an IAM group
1. Make sure you have at least two IAM users in your account.

2. Create a new IAM group and attach at least one policy—perhaps IAMUserChangePassword.
In IAM dashboard → user groups → create group

3. Add two users to the group. Select IAMuserChangePassword Policy.

Select create group

4. Confirm that your users can now change their own passwords.

5. Delete the group or change its policies and then confirm that your users can no longer update their passwords.
Go to IAM → user group → select the group → delete

The group deleted

Login into the IAM user and check the change password option is not working.
