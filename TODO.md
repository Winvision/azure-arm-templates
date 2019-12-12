# functions.json
- Add WebTests
```json
{
    "type": "Microsoft.Insights/webtests",
    "apiVersion": "yyyy-MM-dd",
    "name": "NAME",
    "location": "[parameters('location')]",
    "tags": {
        "[concat('hidden-link:', resourceId('Microsoft.Insights/components', variables('appInsightsName')))]": "Resource"
    },
    "properties": {
        "Name": "NAME",
        "Description": "DESCRIPTION",
        "Enabled": true,
        "Frequency": 300,
        "Timeout": 120,
        "Kind": "ping",
        "RetryEnabled": true,
        "Locations": [{
                "Id": "emea-nl-ams-azr"
            },
            {
                "Id": "emea-gb-db3-azr"
            },
            {
                "Id": "emea-fr-pra-edge"
            }
        ],
        "Configuration": {
            "WebTest": "WEBTEST"
        },
        "SyntheticMonitorId": "NAME"
    }
}
```

- Add Alert Rules
```json
{
    "name": "NAME",
    "apiVersion": "yyyy-MM-dd",
    "type": "Microsoft.Insights/alertrules",
    "location": "[parameters('location')]",
    "tags": {
        "[concat('hidden-link:', resourceId('Microsoft.Insights/components', variables('appInsightsName')))]": "Resource",
        "[concat('hidden-link:', resourceId('Microsoft.Insights/webtests', 'WEBTEST_NAME'))]": "Resource"
    },
    "properties": {
        "name": "NAME",
        "Description": "DESCRIPTION",
        "isEnabled": true,
        "condition": {
            "$type": "Microsoft.WindowsAzure.Management.Monitoring.Alerts.Models.LocationThresholdRuleCondition, Microsoft.WindowsAzure.Management.Mon.Client",
            "odata.type": "Microsoft.Azure.Management.Insights.Models.LocationThresholdRuleCondition",
            "dataSource": {
                "$type": "Microsoft.WindowsAzure.Management.Monitoring.Alerts.Models.RuleMetricDataSource, Microsoft.WindowsAzure.Management.Mon.Client",
                "odata.type": "Microsoft.Azure.Management.Insights.Models.RuleMetricDataSource",
                "resourceUri": "[resourceId('Microsoft.Insights/webtests', 'WEBTEST_NAME')]",
                "metricName": "GSMT_AvRaW"
            },
            "windowSize": "PT5M",
            "failedLocationCount": 2
        },
        "action": {
            "odata.type": "Microsoft.Azure.Management.Insights.Models.RuleEmailAction",
            "sendToServiceOwners": false,
            "customEmails": []
        }
    },
    "dependsOn": [
        "[resourceId('Microsoft.Insights/webtests', 'WEBTEST_NAME')]"
    ]
}
```