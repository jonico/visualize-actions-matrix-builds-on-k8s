#!/bin/bash
export ORG_NAME="planetscale"
echo "::set-output name=ORG_NAME::planetscale"

export DB_NAME="shared-secrets-jonico"
echo "::set-output name=DB_NAME::shared-secrets-jonico"

export BRANCH_NAME="remove-counter"
echo "::set-output name=BRANCH_NAME::remove-counter"

export DEPLOY_REQUEST_NUMBER="3"
echo "::set-output name=DEPLOY_REQUEST_NUMBER::3"

export DEPLOY_REQUEST_URL="https://app.planetscale.com/planetscale/shared-secrets-jonico/deploy-requests/3"
echo "::set-output name=DEPLOY_REQUEST_URL::https://app.planetscale.com/planetscale/shared-secrets-jonico/deploy-requests/3"

export BRANCH_URL="https://app.planetscale.com/planetscale/shared-secrets-jonico/remove-counter"
echo "::set-output name=BRANCH_URL::https://app.planetscale.com/planetscale/shared-secrets-jonico/remove-counter"

