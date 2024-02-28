@contract_interface
namespace IERC721Receiver:
    func onERC721Received(
        operator: felt,
        from: felt,
        tokenId: felt,
        data: felt,
    ) -> (response: felt):
    end
end

@storage_var
func owner_of(token_id: felt) -> (res: felt):
end

@storage_var
func balance_of(account: felt) -> (res: felt):
end

@external
func mint(to: felt, token_id: felt):
    # 检查token_id是否已存在
    let (exists) = owner_of.read(token_id=token_id)
    assert exists == 0

    # 设置NFT的所有者
    owner_of.write(token_id, to)

    # 更新所有者的余额
    let (balance) = balance_of.read(account=to)
    balance_of.write(account=to, value=balance + 1)
    return ()
end

@external
func transfer(from: felt, to: felt, token_id: felt):
    # 验证调用者是否拥有NFT
    let (owner) = owner_of.read(token_id=token_id)
    assert owner == from

    # 更新NFT的所有者
    owner_of.write(token_id, to)

    # 更新余额
    let (balance_from) = balance_of.read(account=from)
    balance_of.write(account=from, value=balance_from - 1)
    
    let (balance_to) = balance_of.read(account=to)
    balance_of.write(account=to, value=balance_to + 1)
    return ()
end