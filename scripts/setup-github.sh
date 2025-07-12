#!/bin/bash

# Fido SBA Copilot - GitHub Repository Setup Script
# This script helps you initialize and push your project to GitHub

set -e

echo "🐕 Setting up Fido SBA Copilot GitHub Repository"
echo "=================================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

# Check if git is installed
if ! command -v git &> /dev/null; then
    print_error "Git is not installed. Please install Git first."
    exit 1
fi

# Check if we're in the right directory
if [ ! -f "backend/index.js" ] || [ ! -f "frontend/index.html" ]; then
    print_error "Please run this script from the project root directory."
    exit 1
fi

# Initialize git repository if not already done
if [ ! -d ".git" ]; then
    print_info "Initializing Git repository..."
    git init
    print_status "Git repository initialized"
else
    print_info "Git repository already exists"
fi

# Add all files
print_info "Adding files to Git..."
git add .
print_status "Files added to staging area"

# Check if there are changes to commit
if git diff --cached --quiet; then
    print_warning "No changes to commit. Repository might already be up to date."
else
    # Initial commit
    print_info "Creating initial commit..."
    git commit -m "feat: initial commit - Fido SBA Copilot

- AI-powered SBA loan guidance chatbot
- Node.js/Express backend with OpenAI integration
- Modern HTML/CSS/JS frontend with glassmorphism design
- MongoDB Atlas database with user authentication
- JWT-based authentication system
- Business plan builder with export functionality
- Production-ready with security features"
    print_status "Initial commit created"
fi

# Ask for GitHub repository URL
echo ""
print_info "Please provide your GitHub repository URL:"
echo "Example: https://github.com/yourusername/fido-sba-copilot.git"
read -p "GitHub URL: " github_url

if [ -z "$github_url" ]; then
    print_error "GitHub URL is required. Please run the script again."
    exit 1
fi

# Add remote origin
print_info "Adding GitHub remote..."
git remote add origin "$github_url"
print_status "GitHub remote added"

# Push to GitHub
print_info "Pushing to GitHub..."
git branch -M main
git push -u origin main
print_status "Code pushed to GitHub successfully!"

echo ""
echo "🎉 Repository Setup Complete!"
echo "=============================="
print_status "Your Fido SBA Copilot is now on GitHub!"
echo ""
print_info "Next steps:"
echo "1. Set up environment variables in your deployment platform"
echo "2. Deploy frontend to Vercel (frontend/ directory)"
echo "3. Deploy backend to Render/Railway/Heroku (backend/ directory)"
echo "4. Update API URLs in frontend/public/main.js"
echo ""
print_info "Check DEPLOYMENT.md for detailed deployment instructions"
echo ""
print_info "Your repository is ready for collaboration! 🚀" 