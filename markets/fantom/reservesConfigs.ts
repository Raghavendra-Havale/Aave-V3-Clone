import {
  rateStrategyStableOne,
  rateStrategyVolatileOne,
} from "../smartlend/rateStrategies";
import { eContractid, IReserveParams } from "../../helpers/types";

export const strategyWFTM: IReserveParams = {
  strategy: rateStrategyVolatileOne,
  baseLTVAsCollateral: "2500",
  liquidationThreshold: "4500",
  liquidationBonus: "11500",
  liquidationProtocolFee: "1000",
  borrowingEnabled: true,
  stableBorrowRateEnabled: false,
  flashLoanEnabled: true,
  reserveDecimals: "18",
  aTokenImpl: eContractid.AToken,
  reserveFactor: "2000",
  supplyCap: "0",
  borrowCap: "0",
  debtCeiling: "0",
  borrowableIsolation: false,
};

export const strategyLINK: IReserveParams = {
  strategy: rateStrategyVolatileOne,
  baseLTVAsCollateral: "5000",
  liquidationThreshold: "6500",
  liquidationBonus: "10750",
  liquidationProtocolFee: "1000",
  borrowingEnabled: true,
  stableBorrowRateEnabled: false,
  flashLoanEnabled: true,
  reserveDecimals: "18",
  aTokenImpl: eContractid.AToken,
  reserveFactor: "2000",
  supplyCap: "0",
  borrowCap: "0",
  debtCeiling: "0",
  borrowableIsolation: false,
};

export const strategyUSDC: IReserveParams = {
  strategy: rateStrategyStableOne,
  baseLTVAsCollateral: "8250",
  liquidationThreshold: "8500",
  liquidationBonus: "10400",
  liquidationProtocolFee: "1000",
  borrowingEnabled: true,
  stableBorrowRateEnabled: true,
  flashLoanEnabled: true,
  reserveDecimals: "6",
  aTokenImpl: eContractid.AToken,
  reserveFactor: "1000",
  supplyCap: "2000000000",
  borrowCap: "0",
  debtCeiling: "0",
  borrowableIsolation: true,
};

export const strategySMARTLEND: IReserveParams = {
  strategy: rateStrategyVolatileOne,
  baseLTVAsCollateral: "6000",
  liquidationThreshold: "7000",
  liquidationBonus: "10750",
  liquidationProtocolFee: "1000",
  borrowingEnabled: false,
  stableBorrowRateEnabled: false,
  flashLoanEnabled: true,
  reserveDecimals: "18",
  aTokenImpl: eContractid.AToken,
  reserveFactor: "0",
  supplyCap: "0",
  borrowCap: "0",
  debtCeiling: "0",
  borrowableIsolation: false,
};

export const strategyWBTC: IReserveParams = {
  strategy: rateStrategyVolatileOne,
  baseLTVAsCollateral: "7000",
  liquidationThreshold: "7500",
  liquidationBonus: "10650",
  liquidationProtocolFee: "1000",
  borrowingEnabled: true,
  stableBorrowRateEnabled: false,
  flashLoanEnabled: true,
  reserveDecimals: "8",
  aTokenImpl: eContractid.AToken,
  reserveFactor: "2000",
  supplyCap: "0",
  borrowCap: "0",
  debtCeiling: "0",
  borrowableIsolation: false,
};

export const strategyCRV: IReserveParams = {
  strategy: rateStrategyVolatileOne,
  baseLTVAsCollateral: "7500",
  liquidationThreshold: "8000",
  liquidationBonus: "10500",
  liquidationProtocolFee: "1000",
  borrowingEnabled: true,
  stableBorrowRateEnabled: false,
  flashLoanEnabled: true,
  reserveDecimals: "18",
  aTokenImpl: eContractid.AToken,
  reserveFactor: "1000",
  supplyCap: "0",
  borrowCap: "0",
  debtCeiling: "0",
  borrowableIsolation: false,
};

export const strategySUSHI: IReserveParams = {
  strategy: rateStrategyVolatileOne,
  baseLTVAsCollateral: "2000",
  liquidationThreshold: "4500",
  liquidationBonus: "11000",
  liquidationProtocolFee: "1000",
  borrowingEnabled: true,
  stableBorrowRateEnabled: false,
  flashLoanEnabled: true,
  reserveDecimals: "18",
  aTokenImpl: eContractid.AToken,
  reserveFactor: "2000",
  supplyCap: "0",
  borrowCap: "0",
  debtCeiling: "0",
  borrowableIsolation: false,
};
