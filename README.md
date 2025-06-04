# Tokenized Energy Smart Grid Management

A comprehensive blockchain-based smart grid management system built with Clarity smart contracts for the Stacks blockchain. This system enables decentralized energy distribution, demand response programs, grid stability monitoring, and renewable energy integration.

## 🌟 Features

### Core Contracts

1. **Utility Verification Contract** (`utility-verification.clar`)
    - Register and verify smart grid utilities
    - Manage utility credentials and capacity
    - Owner-based verification system

2. **Energy Distribution Contract** (`energy-distribution.clar`)
    - Create and manage energy pools
    - Distribute energy to consumers
    - Track distribution records and pricing

3. **Demand Response Contract** (`demand-response.clar`)
    - Create demand response programs
    - Enroll participants and track savings
    - Incentivize energy reduction during peak hours

4. **Grid Stability Contract** (`grid-stability.clar`)
    - Monitor grid metrics (frequency, voltage, load)
    - Set and manage stability thresholds
    - Trigger automated stability responses

5. **Renewable Integration Contract** (`renewable-integration.clar`)
    - Register renewable energy sources
    - Create energy forecasts
    - Track integration metrics and grid penetration

## 🚀 Getting Started

### Prerequisites

- Node.js (v16 or higher)
- Clarinet CLI
- Stacks wallet for testing

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd tokenized-energy-smart-grid
```

2. Install dependencies:
```bash
npm install
```

3. Run tests:
```bash
npm test
```

### Contract Deployment

Deploy contracts to Stacks testnet:

```bash
clarinet deploy --testnet
```

## 📋 Contract Functions

### Utility Verification

- `register-utility(name, capacity)` - Register a new utility
- `verify-utility(utility-id)` - Verify a registered utility
- `get-utility(utility-id)` - Get utility information
- `is-utility-verified(utility-id)` - Check verification status

### Energy Distribution

- `create-energy-pool(total-energy, price-per-unit)` - Create energy pool
- `distribute-energy(pool-id, amount, recipient)` - Distribute energy
- `get-energy-pool(pool-id)` - Get pool information
- `get-distribution-record(record-id)` - Get distribution details

### Demand Response

- `create-demand-program(name, incentive-rate, max-participants)` - Create program
- `enroll-in-program(program-id)` - Enroll in demand response
- `record-participation(program-id, energy-reduced)` - Record participation
- `get-demand-program(program-id)` - Get program details

### Grid Stability

- `record-grid-metrics(frequency, voltage, load)` - Record grid metrics
- `update-stability-threshold(type, min-value, max-value)` - Update thresholds
- `trigger-stability-response()` - Trigger stability response
- `check-grid-stability()` - Check current stability status

### Renewable Integration

- `register-renewable-source(source-type, capacity)` - Register renewable source
- `update-energy-output(source-id, current-output)` - Update energy output
- `create-energy-forecast(source-id, predicted-output, forecast-period)` - Create forecast
- `record-integration-metrics(total-renewable, grid-penetration, stability-impact)` - Record metrics

## 🧪 Testing

The project includes comprehensive test suites for all contracts:

```bash
# Run all tests
npm test

# Run tests in watch mode
npm run test:watch

# Generate coverage report
npm run test:coverage
```

Test files are located in the `tests/` directory and cover:
- Contract function calls
- Error handling
- Data validation
- Integration scenarios

## 🏗️ Architecture

### Smart Contract Structure

```
contracts/
├── utility-verification.clar    # Utility management
├── energy-distribution.clar     # Energy pool management
├── demand-response.clar         # Demand response programs
├── grid-stability.clar          # Grid monitoring
└── renewable-integration.clar   # Renewable energy sources
```

### Data Flow

1. **Utilities** register and get verified through the verification contract
2. **Energy pools** are created and managed for distribution
3. **Consumers** participate in demand response programs
4. **Grid metrics** are continuously monitored for stability
5. **Renewable sources** are integrated and forecasted

## 🔒 Security Features

- Owner-based access control
- Input validation and error handling
- Threshold-based stability monitoring
- Participant enrollment limits
- Energy availability checks

## 🌱 Sustainability Impact

This system promotes:
- **Renewable Energy Integration**: Seamless integration of solar, wind, and other renewable sources
- **Demand Response**: Incentivized energy reduction during peak hours
- **Grid Efficiency**: Optimized energy distribution and reduced waste
- **Transparency**: Blockchain-based tracking of all energy transactions

## 📊 Monitoring & Analytics

The system provides comprehensive monitoring through:
- Real-time grid stability metrics
- Energy distribution tracking
- Renewable energy forecasting
- Demand response participation analytics

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🆘 Support

For support and questions:
- Create an issue in the repository
- Contact the development team
- Check the documentation wiki

## 🔮 Future Enhancements

- Machine learning-based energy forecasting
- Cross-chain energy trading
- IoT device integration
- Advanced analytics dashboard
- Mobile application interface

---

Built with ❤️ for a sustainable energy future
