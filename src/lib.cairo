#[starknet::contract]
mod DiscoverLivePassToken {
    use openzeppelin::token::erc721::ERC721Component;
    use starknet::ContractAddress;

    component!(path: ERC721Component, storage: erc721, event: ERC721Event);

    #[abi(embed_v0)]
    impl ERC721Impl = ERC721Component::ERC721Impl<ContractState>;
    #[abi(embed_v0)]
    impl ERC721MetadataImpl = ERC721Component::ERC721MetadataImpl<ContractState>;
    impl ERC721InternalImpl = ERC721Component::InternalImpl<ContractState>;

    #[storage]
    struct Storage {
        #[substorage(v0)]
        ERC721: ERC721Component::Storage
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        #[flat]
        ERC721Event: ERC721Component::Event
    }

    #[constructor]
    fn constructor(
        ref self: ContractState,
        initial_supply: u256,
        recipient: ContractAddress
    ) {
        let name = 'DiscoverLivePassToken';
        let symbol = 'DLPT';

        self.ERC721.initializer(name, symbol);
        self.ERC721._mint(recipient, initial_supply);
    }

    #[message]
    fn mint(
        ref self: ContractState,
        to: ContractAddress,
        token_id: u256
    ) {
        self.ERC721._mint(to, token_id);
    }

    #[message]
    fn burn(
        ref self: ContractState,
        token_id: u256
    ) {
        self.ERC721._burn(token_id);
    }

    #[message]
    fn transfer(
        ref self: ContractState,
        from: ContractAddress,
        to: ContractAddress,
        token_id: u256
    ) {
        self.ERC721._transfer(from, to, token_id);
    }
}