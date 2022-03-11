const { jestConfig } = require("@salesforce/sfdx-lwc-jest/config");

const setupFilesAfterEnv = jestConfig.setupFilesAfterEnv || [];

module.exports = {
  ...jestConfig,
  moduleNameMapper: {
    "^lightning/navigation$":
      "<rootDir>/force-app/test/jest-mocks/lightning/navigation"
  },
  setupFilesAfterEnv
};
