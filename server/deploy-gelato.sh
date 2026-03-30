#!/bin/bash
# Lala TV - Deploy Gelato + Comet + AIOStreams
# Run on GPU server: bash deploy-gelato.sh

set -e

echo "=== Lala TV - Gelato Stack Deployment ==="
echo ""

# 1. Create directories
echo "[1/5] Creating directories..."
sudo mkdir -p /opt/lala-tv/{comet,comet-pg,aiostreams,gelato/movies,gelato/series}
sudo chown -R 1000:1000 /opt/lala-tv/gelato /opt/lala-tv/aiostreams

# 2. Deploy containers
echo "[2/5] Deploying Comet + AIOStreams..."
sudo docker compose -f /opt/lala-tv/gelato-stack.yml up -d

# 3. Wait for services
echo "[3/5] Waiting for services to start..."
sleep 15

# 4. Check health
echo "[4/5] Checking services..."
curl -s --max-time 5 http://localhost:8000/health && echo " Comet OK" || echo " Comet FAIL"
curl -s --max-time 5 -o /dev/null -w "AIOStreams HTTP:%{http_code}" http://localhost:3001 && echo " OK" || echo " FAIL"

# 5. Install Gelato in Jellyfin
echo "[5/5] Adding Gelato plugin repo to Jellyfin..."
# This needs to be done via Jellyfin web UI:
# Dashboard > Plugins > Repositories > Add:
# https://raw.githubusercontent.com/lostb1t/Gelato/refs/heads/gh-pages/repository.json

echo ""
echo "=== Deployment Complete ==="
echo ""
echo "Next Steps:"
echo ""
echo "1. COMET: Open http://localhost:8000/configure"
echo "   - Select Real-Debrid, paste API token"
echo "   - Enable scrapers (Torrentio, Zilean)"
echo "   - Click Install, copy the manifest URL"
echo ""
echo "2. AIOSTREAMS: Open http://localhost:3001/stremio/configure"
echo "   - Enable Real-Debrid under Services, paste API token"
echo "   - Enable TMDB addon (for search)"
echo "   - Add Comet manifest URL as custom addon"
echo "   - Click Install, copy the final manifest URL"
echo ""
echo "3. JELLYFIN: Dashboard > Plugins > Repositories"
echo "   - Add: https://raw.githubusercontent.com/lostb1t/Gelato/refs/heads/gh-pages/repository.json"
echo "   - Install Gelato from Catalog"
echo "   - Restart Jellyfin"
echo ""
echo "4. GELATO CONFIG: Dashboard > Plugins > Gelato"
echo "   - Stremio URL: paste AIOStreams manifest URL"
echo "   - Movie Base Path: /opt/lala-tv/gelato/movies"
echo "   - Series Base Path: /opt/lala-tv/gelato/series"
echo "   - Save and restart Jellyfin"
echo ""
echo "5. CREATE LIBRARIES:"
echo "   - Add Movies library: /opt/lala-tv/gelato/movies"
echo "   - Add Shows library: /opt/lala-tv/gelato/series"
echo "   - Use TMDB as metadata provider"
echo ""
echo "Real-Debrid API Token: __REVOKED__SET_RD_TOKEN_VIA_ENV__"
echo ""
echo "Services:"
echo "  Comet:      http://localhost:8000"
echo "  AIOStreams:  http://localhost:3001"
echo "  Jellyfin:   http://localhost:8096"
