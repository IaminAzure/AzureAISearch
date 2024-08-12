
param location string = resourceGroup().location

var sharedNamePrefixes = loadJsonContent('./shared-prefixes.json')
var storagename=  '${sharedNamePrefixes.storageaccount}${location}001'
var aisearchservicename = '${sharedNamePrefixes.aisearchservice}${location}-001'


resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storagename
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}


resource search 'Microsoft.Search/searchServices@2020-08-01' = {
  name: aisearchservicename
  location: location
  sku: {
    name: 'free'
  }
  properties: {
    replicaCount: 1
    partitionCount: 1
    hostingMode: 'default'
  }
}


output searchurl string = 'https://${search.name}.search.windows.net'
