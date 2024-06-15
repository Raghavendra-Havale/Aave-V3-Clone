import { HardhatRuntimeEnvironment } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";
import { COMMON_DEPLOY_PARAMS } from "../../helpers/env";

const func: DeployFunction = async function ({
  getNamedAccounts,
  deployments,
  ...hre
}: HardhatRuntimeEnvironment) {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();

  const supplyLogicArtifact = await deploy("SupplyLogic", {
    from: deployer,
    args: [],
    ...COMMON_DEPLOY_PARAMS,
  });

  const borrowLogicArtifact = await deploy("BorrowLogic", {
    from: deployer,
    args: [],
    ...COMMON_DEPLOY_PARAMS,
  });

  const liquidationLogicArtifact = await deploy("LiquidationLogic", {
    from: deployer,
    ...COMMON_DEPLOY_PARAMS,
  });

  const emodeLogicArtifact = await deploy("EModeLogic", {
    from: deployer,
    ...COMMON_DEPLOY_PARAMS,
  });

  const bridgeLogicArtifact = await deploy("BridgeLogic", {
    from: deployer,
    ...COMMON_DEPLOY_PARAMS,
  });

  const configuratorLogicArtifact = await deploy("ConfiguratorLogic", {
    from: deployer,
    ...COMMON_DEPLOY_PARAMS,
  });

  const flashloanLogicArtifact = await deploy("FlashLoanLogic", {
    from: deployer,
    ...COMMON_DEPLOY_PARAMS,
    libraries: {
      BorrowLogic: borrowLogicArtifact.address,
    },
  });

  const poolLogicArtifact = await deploy("PoolLogic", {
    from: deployer,
    ...COMMON_DEPLOY_PARAMS,
  });

  return true;
};

func.id = "LogicLibraries";
func.tags = ["core", "logic"];

export default func;
