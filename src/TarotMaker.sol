// Layout of Contract:
// version
// imports
// errors
// interfaces, libraries, contracts
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// view & pure functions

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {VRFCoordinatorV2Interface} from "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import {VRFConsumerBaseV2} from "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";
import {ConfirmedOwner} from "@chainlink/contracts/src/v0.8/ConfirmedOwner.sol";

/**
 * @title Tarot Maker
 * @author Gmluqa
 * @notice This contract creates a verifiably random Tarot reading
 * @dev This implements Chainlink VRF version 2 and Chainlink Functions
 */

contract TarotMaker is VRFConsumerBaseV2, ConfirmedOwner {
    /* Errors */
    error TarotMaker__NotEnoughFundsSent();

    /* State variables */
    uint256 private immutable i_readingFee;

    // Chainlink VRF Variables
    VRFCoordinatorV2Interface private immutable i_vrfCoordinator;
    uint64 private immutable i_subscriptionId;
    bytes32 private immutable i_gasLane;
    uint32 private immutable i_callbackGasLimit;
    uint16 private constant REQUEST_CONFIRMATIONS = 3;
    uint32 private constant NUM_WORDS = 3;

    mapping(uint256 => string) public tarotDeck;

    /* Events */
    event PaidForReading(address indexed seeker);
    event OwnerWithdraw(uint256 indexed amount);

    constructor(
        uint64 subscriptionId,
        bytes32 gasLane, // keyHash
        uint32 callbackGasLimit,
        address vrfCoordinatorV2,
        uint256 readingFee
    ) ConfirmedOwner(msg.sender) VRFConsumerBaseV2(vrfCoordinatorV2) {
        i_vrfCoordinator = VRFCoordinatorV2Interface(vrfCoordinatorV2);
        i_gasLane = gasLane;
        i_subscriptionId = subscriptionId;
        i_callbackGasLimit = callbackGasLimit;
        i_readingFee = readingFee;

        // Assign card names to corresponding numbers for 22 Major Arcana
        tarotDeck[1] = "The Fool";
        tarotDeck[2] = "The Magician";
        tarotDeck[3] = "The High Priestess";
        tarotDeck[4] = "The Empress";
        tarotDeck[5] = "The Emperor";
        tarotDeck[6] = "The Hierophant";
        tarotDeck[7] = "The Lovers";
        tarotDeck[8] = "The Chariot";
        tarotDeck[9] = "Strength";
        tarotDeck[10] = "The Hermit";
        tarotDeck[11] = "Wheel of Fortune";
        tarotDeck[12] = "Justice";
        tarotDeck[13] = "The Hanged Man";
        tarotDeck[14] = "Death";
        tarotDeck[15] = "Temperance";
        tarotDeck[16] = "The Devil";
        tarotDeck[17] = "The Tower";
        tarotDeck[18] = "The Star";
        tarotDeck[19] = "The Moon";
        tarotDeck[20] = "The Sun";
        tarotDeck[21] = "Judgement";
        tarotDeck[22] = "The World";

        // The 56 Minor Arcana cards (Wands, Cups, Swords, Pentacles)
        for (uint256 i = 23; i <= 78; i++) {
            if (i <= 36) {
                tarotDeck[i] = "Ace of Wands";
            } else if (i <= 50) {
                tarotDeck[i] = "Ace of Cups";
            } else if (i <= 64) {
                tarotDeck[i] = "Ace of Swords";
            } else if (i <= 78) {
                tarotDeck[i] = "Ace of Pentacles";
            }
        }
    }

    function inputTarotPromptAndGetReading(string memory _prompt) external payable {
        if (msg.value < i_readingFee) {
            revert TarotMaker__NotEnoughFundsSent();
        }
        emit PaidForReading(msg.sender);
        uint256[] memory drawnNumbers;
        drawnNumbers = getThreeRandomTarotCards();
        string memory reading = getReading(_prompt, drawnNumbers);
        // return reading;
    }

    function getThreeRandomTarotCards() private pure returns (uint256[] memory) {
        uint256[] memory drawnNumbers;
        while (drawnNumbers.length < 3) {
            // get a random number from 1 to 78 VRF
            // incorporate flowchart into code
        }
        // request 3 random numbers, if any is equal to another, do it again, else, exit loop,
        // probability of getting at least 3 unique numbers in random selection of 3 cards per iteration is approximately 99.99999973%

        return drawnNumbers;
    }

    function getReading(string memory _prompt, uint256[] memory _drawnNumbers) private returns (string memory) {
        string memory reading = "";
        // chainlink functions, openAI LLM call with _prompt and _drawnNumbers
        return reading;
    }

    function requestRandomWords() external returns (uint256 requestId) {}

    function fulfillRandomWords(uint256, /* requestId */ uint256[] memory randomWords) internal override {
        // s_players size 10
        // randomNumber 202
        // 202 % 10 ? what's doesn't divide evenly into 202?
        // 20 * 10 = 200
        // 2
        // 202 % 10 = 2
        // uint256 indexOfWinner = randomWords[0] % s_players.length;
        // address payable recentWinner = s_players[indexOfWinner];
        // s_recentWinner = recentWinner;
        // s_players = new address payable[](0);
        // s_raffleState = RaffleState.OPEN;
        // s_lastTimeStamp = block.timestamp;
        // emit WinnerPicked(recentWinner);
        // (bool success, ) = recentWinner.call{value: address(this).balance}("");
        // // require(success, "Transfer failed");
        // if (!success) {
        //     revert Raffle__TransferFailed();
        // }
    }

    // Check this function works lol
    function withdrawFunds() external onlyOwner {
        uint256 balance = address(this).balance;
        // Ensure there are funds to withdraw
        // TODO make this an IF revert Error
        require(balance > 0, "No funds available for withdrawal");
        // Transfer the entire balance to the owner
        payable(msg.sender).transfer(balance);
        // Emit the Withdrawal event
        emit OwnerWithdraw(balance);
    }
}
