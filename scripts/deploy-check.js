#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

console.log('🔍 Fido SBA Copilot - Deployment Check\n');

let allChecksPassed = true;

// Check 1: Environment variables
console.log('1. Checking environment variables...');
if (!process.env.OPENAI_API_KEY) {
  console.log('   ❌ OPENAI_API_KEY not found in environment');
  allChecksPassed = false;
} else {
  console.log('   ✅ OPENAI_API_KEY is set');
}

// Check 2: Required files exist
console.log('\n2. Checking required files...');
const requiredFiles = [
  'backend/index.js',
  'backend/package.json',
  'frontend/index.html',
  'frontend/public/main.js',
  'frontend/public/styles.css',
  '.gitignore'
];

requiredFiles.forEach(file => {
  if (fs.existsSync(file)) {
    console.log(`   ✅ ${file} exists`);
  } else {
    console.log(`   ❌ ${file} missing`);
    allChecksPassed = false;
  }
});

// Check 3: Backend dependencies
console.log('\n3. Checking backend dependencies...');
try {
  const backendPackage = JSON.parse(fs.readFileSync('backend/package.json', 'utf8'));
  const requiredDeps = ['express', 'cors', 'openai', 'dotenv'];
  
  requiredDeps.forEach(dep => {
    if (backendPackage.dependencies && backendPackage.dependencies[dep]) {
      console.log(`   ✅ ${dep} is installed`);
    } else {
      console.log(`   ❌ ${dep} is missing`);
      allChecksPassed = false;
    }
  });
} catch (error) {
  console.log('   ❌ Could not read backend/package.json');
  allChecksPassed = false;
}

// Check 4: Security checks
console.log('\n4. Security checks...');
const backendCode = fs.readFileSync('backend/index.js', 'utf8');

if (backendCode.includes('sk-')) {
  console.log('   ❌ API key found in code (security risk)');
  allChecksPassed = false;
} else {
  console.log('   ✅ No hardcoded API keys found');
}

if (backendCode.includes('helmet') && backendCode.includes('rateLimit')) {
  console.log('   ✅ Security middleware detected');
} else {
  console.log('   ⚠️  Security middleware may be missing');
}

// Check 5: Frontend connectivity
console.log('\n5. Frontend connectivity...');
const frontendCode = fs.readFileSync('frontend/public/main.js', 'utf8');
if (frontendCode.includes('localhost:3000')) {
  console.log('   ✅ Frontend configured for localhost:3000');
} else {
  console.log('   ⚠️  Frontend may not be configured for correct backend URL');
}

// Summary
console.log('\n' + '='.repeat(50));
if (allChecksPassed) {
  console.log('🎉 All checks passed! Ready for deployment.');
  process.exit(0);
} else {
  console.log('❌ Some checks failed. Please fix issues before deploying.');
  process.exit(1);
} 