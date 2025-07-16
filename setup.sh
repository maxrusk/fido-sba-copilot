#!/bin/bash

# Fido SBA Copilot - Setup Script
# This script helps you set up and deploy the Fido SBA Copilot application

echo "🐕 Fido SBA Copilot - Setup Script"
echo "=================================="
echo ""

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

# Check if Node.js is installed
check_node() {
    if command -v node &> /dev/null; then
        NODE_VERSION=$(node --version)
        print_status "Node.js is installed: $NODE_VERSION"
        
        # Check if version is >= 16
        NODE_MAJOR=$(echo $NODE_VERSION | cut -d'.' -f1 | sed 's/v//')
        if [ "$NODE_MAJOR" -ge 16 ]; then
            print_status "Node.js version is compatible (>=16.0.0)"
        else
            print_error "Node.js version must be >= 16.0.0. Current: $NODE_VERSION"
            exit 1
        fi
    else
        print_error "Node.js is not installed. Please install Node.js 16+ from https://nodejs.org/"
        exit 1
    fi
}

# Check if npm is installed
check_npm() {
    if command -v npm &> /dev/null; then
        NPM_VERSION=$(npm --version)
        print_status "npm is installed: $NPM_VERSION"
    else
        print_error "npm is not installed. Please install npm"
        exit 1
    fi
}

# Install backend dependencies
install_backend_deps() {
    print_info "Installing backend dependencies..."
    cd backend
    
    if [ ! -f "package.json" ]; then
        print_error "backend/package.json not found!"
        exit 1
    fi
    
    npm install
    if [ $? -eq 0 ]; then
        print_status "Backend dependencies installed successfully"
    else
        print_error "Failed to install backend dependencies"
        exit 1
    fi
    
    cd ..
}

# Create environment file
create_env_file() {
    print_info "Setting up environment configuration..."
    
    if [ ! -f "backend/.env" ]; then
        if [ -f "backend/.env.example" ]; then
            cp backend/.env.example backend/.env
            print_status "Created .env file from .env.example"
            print_warning "Please edit backend/.env with your actual API keys and database URL"
        else
            print_error "backend/.env.example not found!"
            exit 1
        fi
    else
        print_status "Environment file already exists"
    fi
}

# Check required environment variables
check_env_vars() {
    print_info "Checking environment variables..."
    
    if [ -f "backend/.env" ]; then
        source backend/.env
        
        if [ -z "$OPENAI_API_KEY" ] || [ "$OPENAI_API_KEY" = "your_openai_api_key_here" ]; then
            print_warning "OPENAI_API_KEY not set in .env file"
        else
            print_status "OPENAI_API_KEY is configured"
        fi
        
        if [ -z "$MONGODB_URI" ] || [ "$MONGODB_URI" = "mongodb+srv://username:password@cluster.mongodb.net/fido?retryWrites=true&w=majority" ]; then
            print_warning "MONGODB_URI not set in .env file"
        else
            print_status "MONGODB_URI is configured"
        fi
        
        if [ -z "$JWT_SECRET" ] || [ "$JWT_SECRET" = "your_super_secure_jwt_secret_key_here" ]; then
            print_warning "JWT_SECRET not set in .env file"
        else
            print_status "JWT_SECRET is configured"
        fi
    else
        print_error "backend/.env file not found!"
        exit 1
    fi
}

# Test backend startup
test_backend() {
    print_info "Testing backend startup..."
    
    cd backend
    timeout 10s node index.js &
    BACKEND_PID=$!
    
    sleep 3
    
    if kill -0 $BACKEND_PID 2>/dev/null; then
        print_status "Backend starts successfully"
        kill $BACKEND_PID
    else
        print_error "Backend failed to start"
        exit 1
    fi
    
    cd ..
}

# Run deployment check
run_deployment_check() {
    print_info "Running deployment check..."
    
    npm run deploy:check
    if [ $? -eq 0 ]; then
        print_status "All deployment checks passed!"
    else
        print_warning "Some deployment checks failed. Please review the output above."
    fi
}

# Display next steps
show_next_steps() {
    echo ""
    echo "🚀 Setup Complete!"
    echo "=================="
    echo ""
    echo "Next steps:"
    echo "1. Configure your environment variables in backend/.env:"
    echo "   - OPENAI_API_KEY: Get from https://platform.openai.com/api-keys"
    echo "   - MONGODB_URI: Get from https://mongodb.com/atlas"
    echo "   - JWT_SECRET: Generate a secure random string"
    echo ""
    echo "2. Test locally:"
    echo "   cd backend && npm run dev"
    echo "   Open frontend/index.html in your browser"
    echo ""
    echo "3. Deploy to production:"
    echo "   - Backend: Deploy to Render, Railway, or Heroku"
    echo "   - Frontend: Deploy to Vercel or Netlify"
    echo ""
    echo "4. Read the deployment guides:"
    echo "   - DEPLOYMENT.md - Comprehensive deployment guide"
    echo "   - DEPLOYMENT_CHECKLIST.md - Step-by-step checklist"
    echo "   - DEPLOYMENT_GUIDE.md - Updated deployment strategy"
    echo ""
    print_status "Happy coding! 🐕"
}

# Main execution
main() {
    check_node
    check_npm
    install_backend_deps
    create_env_file
    check_env_vars
    test_backend
    run_deployment_check
    show_next_steps
}

# Run main function
main