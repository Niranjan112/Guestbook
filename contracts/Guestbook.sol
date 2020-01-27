pragma solidity >=0.4.21 <0.6.0;

contract Guestbook {
  event SignatureAdded(string message, bytes32 name);
  bytes32[] guests;
  function signBook(bytes32 name) public {
    guests.push(name);
    emit SignatureAdded("New guest signature!", name);
  }
  function editNames(uint256 _index, bytes32 _name) public {
    guests[_index] = _name;
  }

  function getNames() public view returns (bytes32[] memory) {
    return guests;
  }
}