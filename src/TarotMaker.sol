// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {VRFCoordinatorV2Interface} from "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";

contract TarotMaker {
    mapping(uint256 => string) public tarotDeck;

    constructor() {
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

    function inputTarotPromptAndGetReading(string memory _prompt) public {
        uint256[] memory drawnNumbers;
        drawnNumbers = getThreeRandomTarotCards();
        string memory reading = getReading(_prompt, drawnNumbers);
        // return reading;
    }

    function getThreeRandomTarotCards() private returns (uint256[] memory) {
        uint256[] memory drawnNumbers;
        while (drawnNumbers.length < 3) {
            // get a random number from 1 to 78 VRF
            // incorporate flowchart into code
        }

        return drawnNumbers;
    }

    function getReading(string memory _prompt, uint256[] memory _drawnNumbers) private returns (string memory) {
        string memory reading = "";
        // chainlink functions, openAI LLM call with _prompt and _drawnNumbers
        return reading;
    }
}
