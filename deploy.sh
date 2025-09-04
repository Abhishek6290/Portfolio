#!/bin/bash

# Portfolio Deployment Script
# This script helps prepare your portfolio for deployment

echo "🚀 Portfolio Deployment Helper"
echo "================================"

# Check if we're in the right directory
if [ ! -f "index.html" ]; then
    echo "❌ Error: index.html not found. Please run this script from the portfolio directory."
    exit 1
fi

# Create assets directory if it doesn't exist
if [ ! -d "assets" ]; then
    echo "📁 Creating assets directory..."
    mkdir assets
fi

# Check for required files
echo "🔍 Checking required files..."

required_files=("index.html" "css/style.css" "js/script.js")
missing_files=()

for file in "${required_files[@]}"; do
    if [ ! -f "$file" ]; then
        missing_files+=("$file")
    fi
done

if [ ${#missing_files[@]} -eq 0 ]; then
    echo "✅ All required files found"
else
    echo "❌ Missing files:"
    for file in "${missing_files[@]}"; do
        echo "   - $file"
    done
fi

# Check for assets
echo "🖼️  Checking assets..."
assets=("assets/profile.jpg" "assets/project1.jpg" "assets/project2.jpg")
missing_assets=()

for asset in "${assets[@]}"; do
    if [ ! -f "$asset" ]; then
        missing_assets+=("$asset")
    fi
done

if [ ${#missing_assets[@]} -eq 0 ]; then
    echo "✅ All asset files found"
else
    echo "⚠️  Missing assets (these are optional but recommended):"
    for asset in "${missing_assets[@]}"; do
        echo "   - $asset"
    done
    echo "💡 Tip: Use create_placeholders.html to generate placeholder images"
fi

# Validate HTML
echo "📝 Basic HTML validation..."
if grep -q "</html>" index.html; then
    echo "✅ HTML file appears to be valid"
else
    echo "⚠️  HTML file may be incomplete"
fi

# Check for personal customization
echo "🔧 Checking customization..."
if grep -q "abhishekverma@gmail.com" index.html; then
    echo "✅ Contact information found"
else
    echo "⚠️  Please update contact information in index.html"
fi

if grep -q "linkedin.com" index.html; then
    echo "✅ LinkedIn link found"
else
    echo "⚠️  Please update LinkedIn link in index.html"
fi

# File size check
echo "📊 File size analysis..."
total_size=0
for file in index.html css/style.css js/script.js; do
    if [ -f "$file" ]; then
        size=$(stat -c%s "$file" 2>/dev/null || stat -f%z "$file" 2>/dev/null)
        total_size=$((total_size + size))
        echo "   $file: $(echo "scale=1; $size/1024" | bc 2>/dev/null || echo "$((size/1024))")KB"
    fi
done

echo "   Total: $(echo "scale=1; $total_size/1024" | bc 2>/dev/null || echo "$((total_size/1024))")KB"

# Deployment suggestions
echo ""
echo "🌐 Deployment Options:"
echo "1. GitHub Pages:"
echo "   - Push to GitHub repository"
echo "   - Enable Pages in repository settings"
echo "   - Your site: https://username.github.io/repository-name"
echo ""
echo "2. Netlify:"
echo "   - Drag & drop the portfolio folder to netlify.com"
echo "   - Or connect your GitHub repository"
echo ""
echo "3. Vercel:"
echo "   - Connect your GitHub repository to vercel.com"
echo "   - Automatic deployment on every push"
echo ""

# Final checklist
echo "✅ Pre-deployment Checklist:"
echo "   □ Add your real profile photo to assets/profile.jpg"
echo "   □ Add your project screenshots to assets/"
echo "   □ Update contact information and social links"
echo "   □ Test on mobile devices"
echo "   □ Update project GitHub links"
echo "   □ Set up contact form functionality"
echo ""
echo "🎉 Your portfolio is ready for deployment!"
echo "💡 Tip: Test locally first by opening index.html in your browser"
