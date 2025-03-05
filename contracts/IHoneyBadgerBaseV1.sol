//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

interface IHoneyBadgerBaseV1
{
    enum CallCodes
    {
        None, //0
        InitCreate, //1
        InsertNewMember, //2
        Push, //3
        Put, //4
        Put256, //5
        PutString, //6
        PutBatch, //7
        Get, //8
        Get256, //9
        GetString, //10
        GetBatch //11
    }

    struct MemberData
    {
        uint256 valType;
        uint256 size;
        uint256 bitCount;
    }

    enum EventLevels
    {
        None,
        Discrete,
        Transparent
    }

    enum PermissionFlags 
    {
        None, //0
        View, //1
        Modify, //2
        PermissionManagement, //3
        StorageSpace //4
    }

    struct UserSlotArgs
    {
        uint256 entryIndex;
        uint256 storageSpace;
        uint256 entryStringIndex;
        uint256 ROOT_SLOT;
        bool isString;
        bytes specialAccess;
    }

    function strip_permissions(address user) external returns (bool);

    function update_permissions(address user, uint8[] memory flags, bool remove) external;

    function view_permissions(address user) external view returns (uint256);

    function init_create(
    uint256[] memory types,
    uint256[] memory sizes,
    bool specialAccess) 
    external returns(uint256);

    function insert_new_member(
        uint256 valType,
        uint256 size,
        uint256 storageSpace
    ) external; 

    function push(uint256 amount, uint256 storageSpace) external;

    function put(
        uint256 data,
        uint256 memberIndex,
        uint256 entryIndex,
        uint256 storageSpace,
        bytes calldata specialAccess
    ) external;

    function put256(
        uint256 data,
        uint256 memberIndex,
        uint256 entryIndex,
        uint256 storageSpace,
        bytes calldata specialAccess
    ) external;


    function put_string(
        string memory data,
        uint256 memberIndex,
        uint256 entryIndex,
        uint256 storageSpace,
        bytes calldata specialAccess
    ) external;

    function put_batch(
        uint256[] memory values,
        uint256[] memory members,
        uint256 entryIndex,
        uint256 storageSpace,
        bytes calldata specialAccess
    ) external;
    
    function get(
        uint256 memberIndex,
        uint256 entryIndex,
        uint256 storageSpace,
        bytes calldata specialAccess
    ) external view returns (uint256);

    function get256(
        uint256 memberIndex,
        uint256 entryIndex,
        uint256 storageSpace,
        bytes calldata specialAccess
    ) external view returns (uint256);

    function get_string(
        uint256 memberIndex,
        uint256 entryIndex,
        uint256 storageSpace,
        bytes calldata specialAccess
    ) external view returns (string memory returnValue);
    
    function get_batch(
        uint256[] memory members,
        uint256 entryIndex,
        uint256 storageSpace,
        bytes calldata specialAccess
    ) external view returns (uint256[] memory result);
    
    function get_string_size(
        uint256 memberIndex,
        uint256 entryIndex,
        uint256 storageSpace
    ) external view returns (uint256 size);
   
    function transparency_audit()
        external view
        returns (address[] memory, uint256[] memory permissionLevels);

    function address_indexed(
        address target,
        uint256 storageSpace
    ) external view returns(uint256);
}