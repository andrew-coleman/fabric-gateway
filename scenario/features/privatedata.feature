#
# Copyright 2021 IBM All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0
#
Feature: Private data
    Background:
        Given I have deployed a Fabric network
        And I have created and joined all channels
        And I deploy golang chaincode named basic at version 1.0.0 for all organizations on channel mychannel with endorsement policy OR("Org1MSP.member","Org2MSP.member","Org3MSP.member")
        And I create a gateway for user User1 in MSP Org1MSP
        And I connect the gateway to peer0.org1.example.com
        And I use the mychannel network
        And I use the basic contract

    Scenario: Submit to org1
        When I prepare to submit a getPeerOrg transaction
        And I set the endorsing organizations to ["Org1MSP"]
        And I invoke the transaction
        Then the response should be "Org1MSP"

    Scenario: Submit to org2
        When I prepare to submit a getPeerOrg transaction
        And I set the endorsing organizations to ["Org2MSP"]
        And I invoke the transaction
        Then the response should be "Org2MSP"

    Scenario: Submit to org3
        When I prepare to submit a getPeerOrg transaction
        And I set the endorsing organizations to ["Org3MSP"]
        And I invoke the transaction
        Then the response should be "Org3MSP"

    Scenario: Submit to org1 and org3
        When I prepare to submit a checkEndorsingOrg transaction
        And I set the endorsing organizations to ["Org1MSP", "Org3MSP"]
        And I set transient data on the transaction to
            | Org1MSP | value1 |
            | Org3MSP | value2 |
        And I invoke the transaction
        Then the response should be "success"

    Scenario: Evaluate on org1
        When I prepare to evaluate a getPeerOrg transaction
        And I set the endorsing organizations to ["Org1MSP"]
        And I invoke the transaction
        Then the response should be "Org1MSP"

    Scenario: Evaluate on org2
        When I prepare to evaluate a getPeerOrg transaction
        And I set the endorsing organizations to ["Org2MSP"]
        And I invoke the transaction
        Then the response should be "Org2MSP"

