# GitHub Upload Instructions

## Folder Ready for Upload

📁 **Location:** `/Users/mahindragupthakotha/Downloads/Microservices Deployment/interview-repo/github`

---

## Folder Contents

```
github/
├── .gitignore                    # Git ignore rules
├── README.md                     # Project overview
├── SUBMISSION.md                 # Complete documentation with architecture
├── EVIDENCE.md                   # Deployment proof and verification
├── SCREENSHOT_GUIDE.md          # AWS screenshots guide (NEW!)
├── docker-compose.yml            # Container orchestration
├── scripts/
│   ├── deploy_fast.sh           # Automated deployment script
│   ├── verify_endpoints.sh      # Verification script (Stage E)
│   └── cleanup.sh               # Resource cleanup script
└── servers/
    ├── docker-compose.yml       # Local development compose
    ├── service1/
    │   ├── Dockerfile
    │   ├── requirements.txt
    │   └── service1.py
    └── service2/
        ├── Dockerfile
        ├── requirements.txt
        └── service2.py
```

---

## Method 1: Upload via GitHub Web Interface

### Steps:

1. **Go to your GitHub repository**
   - Navigate to: https://github.com/YOUR_USERNAME/YOUR_REPO_NAME

2. **Upload files**
   - Click "Add file" → "Upload files"
   - Drag and drop the entire `github` folder contents
   - OR click "choose your files" and select all files/folders

3. **Commit changes**
   - Add commit message: "Initial deployment - AWS microservices architecture"
   - Click "Commit changes"

---

## Method 2: Upload via Git Command Line (Recommended)

### Steps:

```bash
# Navigate to the github folder
cd "/Users/mahindragupthakotha/Downloads/Microservices Deployment/interview-repo/github"

# Initialize git repository (if not already initialized)
git init

# Add your GitHub remote (replace with your repo URL)
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git

# Create main branch and switch to it
git checkout -b main

# Add all files
git add .

# Commit files
git commit -m "Initial deployment: AWS microservices with ECR, EC2, and ALB"

# Push to GitHub
git push -u origin main
```

### If repository already exists on GitHub:

```bash
cd "/Users/mahindragupthakotha/Downloads/Microservices Deployment/interview-repo/github"

# Clone your empty repository
# git clone https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git temp_repo
# cp -r * temp_repo/
# cd temp_repo

# OR if already cloned, just copy files
# Copy all files from github folder to your cloned repo
# Then:

git add .
git commit -m "Add microservices deployment with AWS infrastructure"
git push origin main
```

---

## Method 3: Using GitHub Desktop

1. Open GitHub Desktop
2. File → Add Local Repository
3. Choose the `github` folder
4. Publish repository to GitHub
5. Push changes

---

## What's Included

✅ **Source Code:**
- service1.py - Flask microservice 1
- service2.py - Flask microservice 2
- Dockerfiles for both services
- requirements.txt files

✅ **Infrastructure as Code:**
- deploy_fast.sh - Full automated deployment
- docker-compose.yml - Container orchestration
- cleanup.sh - Resource teardown

✅ **Documentation:**
- README.md - Project overview
- SUBMISSION.md - Complete architecture & deployment guide
- EVIDENCE.md - Deployment proof with outputs
- SCREENSHOT_GUIDE.md - AWS screenshot instructions

✅ **Verification:**
- verify_endpoints.sh - Stage E verification script

✅ **Configuration:**
- .gitignore - Excludes unnecessary files

---

## After Upload - Take Screenshots

Once uploaded to GitHub, follow the **SCREENSHOT_GUIDE.md** to capture:

### Priority Screenshots:
1. ✅ Target groups showing HEALTHY status
2. ✅ Browser tests of both endpoints
3. ✅ EC2 instances running
4. ✅ ECR repositories with images
5. ✅ Load balancer active

See SCREENSHOT_GUIDE.md for detailed instructions!

---

## Quick Verification Commands

After uploading, verify your AWS resources are still healthy:

```bash
# Check services are responding
curl http://interview-ms-alb-786872323.us-east-1.elb.amazonaws.com/service1
curl http://interview-ms-alb-786872323.us-east-1.elb.amazonaws.com/service2

# Check target health
aws elbv2 describe-target-health --region us-east-1 \
  --target-group-arn arn:aws:elasticloadbalancing:us-east-1:886701197972:targetgroup/interview-ms-tg-s1/f10736a7d70abea4 \
  --query 'TargetHealthDescriptions[*].[Target.Id,TargetHealth.State]' \
  --output table
```

---

## Important Notes

⚠️ **Security:**
- Never commit `.pem` key files (already in .gitignore)
- Never commit AWS credentials
- The .gitignore file protects sensitive files

📝 **Repository Settings:**
- Make repository Public if it's for interview submission
- Add a good repository description
- Consider adding topics/tags: `aws`, `docker`, `microservices`, `devops`

🎯 **Final Checklist:**
- [ ] All files uploaded to GitHub
- [ ] README.md visible and formatted correctly
- [ ] Repository is Public (if required)
- [ ] Screenshots taken and organized
- [ ] Services still accessible and healthy
- [ ] Repository URL ready to share

---

**Your GitHub folder is ready! 🚀**

Location: `/Users/mahindragupthakotha/Downloads/Microservices Deployment/interview-repo/github`
