/*
Copyright 2020 IBM All Rights Reserved.

SPDX-License-Identifier: Apache-2.0
*/

package client

import (
	"testing"

	"github.com/golang/mock/gomock"
)

func AssertNewTestNetwork(t *testing.T, networkName string, options ...ConnectOption) *Network {
	gateway := AssertNewTestGateway(t, options...)
	return gateway.GetNetwork(networkName)
}

func TestNetwork(t *testing.T) {
	t.Run("GetContract returns correctly named Contract", func(t *testing.T) {
		chaincodeID := "chaincode"
		mockClient := NewMockGatewayClient(gomock.NewController(t))
		network := AssertNewTestNetwork(t, "network", WithClient(mockClient))

		contract := network.GetContract(chaincodeID)

		if nil == contract {
			t.Fatal("Expected network, got nil")
		}
		if contract.ChaincodeID() != chaincodeID {
			t.Fatalf("Expected a network with chaincode ID %s, got %s", chaincodeID, contract.ChaincodeID())
		}
		if len(contract.Name()) > 0 {
			t.Fatalf("Expected a network with empty contract name, got %s", contract.Name())
		}
	})

	t.Run("GetContractWithName returns correctly named Contract", func(t *testing.T) {
		chaincodeID := "chaincode"
		contractName := "contract"
		mockClient := NewMockGatewayClient(gomock.NewController(t))
		network := AssertNewTestNetwork(t, "network", WithClient(mockClient))

		contract := network.GetContractWithName(chaincodeID, contractName)

		if nil == contract {
			t.Fatal("Expected network, got nil")
		}
		if contract.ChaincodeID() != chaincodeID {
			t.Fatalf("Expected a network with chaincode ID %s, got %s", chaincodeID, contract.ChaincodeID())
		}
		if contract.Name() != contractName {
			t.Fatalf("Expected a network with contract name %s, got %s", contractName, contract.Name())
		}
	})
}
