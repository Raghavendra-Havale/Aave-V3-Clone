import { eEthereumNetwork, ISmartLendConfiguration } from "../../helpers/types";
import { SmartLendMarket } from "../smartlend/index";

// ----------------
// POOL--SPECIFIC PARAMS
// ----------------

export const EthereumV3Market: ISmartLendConfiguration = {
  ...SmartLendMarket,
  ProviderId: 30,
  WrappedNativeTokenSymbol: "WETH",
  MarketId: "SmartLend Ethereum Market",
  ATokenNamePrefix: "Ethereum",
  StableDebtTokenNamePrefix: "Ethereum",
  VariableDebtTokenNamePrefix: "Ethereum",
  SymbolPrefix: "Eth",
  ReserveAssets: {},
  ChainlinkAggregator: {},
  ReservesConfig: {},
  EModes: {},
  ReserveFactorTreasuryAddress: {
    [eEthereumNetwork.main]: "0x464c71f6c2f760dda6093dcb91c24c39e5d6e18c",
  },
};

export default EthereumV3Market;
