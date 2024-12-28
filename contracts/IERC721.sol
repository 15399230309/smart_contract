// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

interface IERC165 {
    function supportsInterface(bytes4 interfaceID) external view returns (bool);
}

interface IERC721Receiver {
    function onERC721Received(
        address operatior,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4);
}

interface IERC721 is IERC165 {
    function balanceOf(address owner) external view returns (uint256 balance);

    function ownerOf(uint256 tokenId) external view returns (address owner);

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;

    function TransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;

    function approve(address to, uint256 tokenId) external;

    function getApproved(uint256 tokenId)
        external
        view
        returns (address operator);

    function setApprovedForAll(address operator, bool _approved) external;

    function isApprovedForAll(address oowner, address operator)
        external
        returns (bool _approved);
}

contract ERC721 is IERC721 {
    event Transfer(
        address indexed from,
        address indexed to,
        uint256 indexed id
    );
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 indexed id
    );
    event ApprovalForAll(
        address indexed owner,
        address indexed operator,
        bool approved
    );
    mapping(address => uint256) internal _balanceOf;
    mapping(uint256 => address) internal _ownerOf;
    mapping(uint256 => address) internal _approvals;
    mapping(address => mapping(address => bool)) public  isApprovedForAll;

    function supportsInterface(bytes4 interfaceID)
        external
        pure 
        returns (bool)
    {
        return
            interfaceID == type(IERC721).interfaceId ||
            interfaceID == type(IERC165).interfaceId;
    }

    function balanceOf(address owner) external view returns (uint256 balance) {
        require(owner != address(0), "zero address");
        return _balanceOf[owner];
    }

    function ownerOf(uint256 tokenId) external view returns (address owner) {
        owner = _ownerOf[tokenId];
        require(owner != address(0), "zero address");
    }

    function setApprovedForAll(address operator, bool _approved) external {
        isApprovedForAll[msg.sender][operator] = _approved;
        emit ApprovalForAll(msg.sender, operator, _approved);
    }

    function getApproved(uint256 tokenId)
        external
        view
        returns (address operator)
    {
        require(_approvals[tokenId] != address(0), "tokenId not exists");
        return _approvals[tokenId];
    }

    function approve(address to, uint256 tokenId) external {
        address owner = _approvals[tokenId];
        require(
            msg.sender == owner || isApprovedForAll[owner][msg.sender],
            "not auth"
        );
        _approvals[tokenId] = to;
    }

    function _isApprovedOrOwner(
        address owner,
        address spender,
        uint256 tokenId
    ) external view returns (bool) {
        return
            owner == spender ||
            _approvals[tokenId] == spender ||
            isApprovedForAll[owner][spender];
    }

    function TransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public {
        address owner = _ownerOf[tokenId];
        require(
            from == owner ||
                msg.sender == owner ||
                isApprovedForAll[owner][msg.sender]
        );
        _balanceOf[from]--;
        _balanceOf[to]++;
        _ownerOf[tokenId] = to;
        delete _approvals[tokenId];
        emit Transfer(from, to, tokenId);
    }

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external {
        TransferFrom(from, to, tokenId);

        require(
            to.code.length == 0 ||
                IERC721Receiver(to).onERC721Received(
                    msg.sender,
                    from,
                    tokenId,
                    "") == IERC721Receiver.onERC721Received.selector,"unsafe recipient");
        
    }

    function _mint(address to, uint tokenId) internal {
        require(to != address(0), "to = zero address");
        require(_ownerOf[tokenId] == address(0), "token exists");
        _balanceOf[to] ++;
        _ownerOf[tokenId] = to;
        emit Transfer(address(0), to, tokenId);
    }
    function _burn(uint tokenId) internal {
        address owner = _ownerOf[tokenId];
        require(owner != address(0), "token does not exist");
        _balanceOf[owner]--;
        delete _ownerOf[tokenId];
        delete _approvals[tokenId];
        emit Transfer(owner, address(0), tokenId);
    }
}

contract MyNft is ERC721{

    function mint (address to ,uint256 tokenId)external {
        _mint(to,tokenId);
    }
 function burn(uint tokenId) external {
        require(msg.sender == _ownerOf[tokenId], "not owner");
        _burn(tokenId);
 }
}