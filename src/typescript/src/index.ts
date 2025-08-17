// TypeScript test file for Neovim configuration validation
import { debounce } from 'lodash';

// Interface for testing autocomplete and type checking
interface Person {
  id: number;
  name: string;
  email: string;
  age: number;
  isActive?: boolean;
  createdAt: Date;
}

// Type aliases for testing navigation
type PersonStatus = 'active' | 'inactive' | 'pending';
type PersonRole = 'admin' | 'user' | 'moderator';

// Class for testing LSP features
export class PersonManager {
  private people: Person[] = [];
  private nextId = 1;

  constructor() {
    // Add some test data
    this.addPerson('Alice Johnson', 'alice@example.com', 30);
    this.addPerson('Bob Smith', 'bob@test.org', 25);
    this.addPerson('Carol Davis', 'carol@company.com', 35);
  }

  // Method with proper typing for testing autocomplete
  public addPerson(name: string, email: string, age: number): Person {
    const newPerson: Person = {
      id: this.nextId++,
      name,
      email,
      age,
      isActive: true,
      createdAt: new Date(),
    };

    // Test autocomplete - try typing "this." to see suggestions
    this.people.push(newPerson);
    console.log(`Added person: ${newPerson.name}`);

    return newPerson;
  }

  // Method for testing go-to-definition
  public findPersonById(id: number): Person | undefined {
    return this.people.find((person) => person.id === id);
  }

  // Method for testing find references
  public findPersonByEmail(email: string): Person | undefined {
    return this.people.find((person) => person.email === email);
  }

  // Method with complex types for testing
  public updatePersonStatus(id: number, status: PersonStatus): boolean {
    const person = this.findPersonById(id);
    if (!person) {
      console.warn(`Person with ID ${id} not found`);
      return false;
    }

    person.isActive = status === 'active';
    console.log(`Updated ${person.name} status to ${status}`);
    return true;
  }

  // Async method for testing
  public async getAllPeople(): Promise<Person[]> {
    // Simulate async operation
    await new Promise((resolve) => setTimeout(resolve, 100));
    return [...this.people];
  }

  // Method with array operations
  public getAdults(): Person[] {
    return this.people.filter((person) => person.age >= 18);
  }

  // Method using lodash for testing imports
  public searchPeople = debounce((query: string): Person[] => {
    return this.people.filter((person) =>
      person.name.toLowerCase().includes(query.toLowerCase())
    );
  }, 300);
}

// Utility class for testing
export class Calculator {
  public add(a: number, b: number): number {
    return a + b;
  }

  public divide(a: number, b: number): number {
    if (b === 0) {
      throw new Error('Cannot divide by zero');
    }
    return a / b;
  }

  public calculateAverage(numbers: number[]): number {
    if (numbers.length === 0) {
      throw new Error('Cannot calculate average of empty array');
    }

    const sum = numbers.reduce((acc, num) => acc + num, 0);
    return sum / numbers.length;
  }
}

// Function with error handling for testing
export function processPersonData(data: unknown): Person {
  if (!data || typeof data !== 'object') {
    throw new Error('Invalid data provided');
  }

  const obj = data as Record<string, unknown>;

  // Type guards for testing
  if (typeof obj.name !== 'string') {
    throw new Error('Name must be a string');
  }

  if (typeof obj.email !== 'string') {
    throw new Error('Email must be a string');
  }

  if (typeof obj.age !== 'number') {
    throw new Error('Age must be a number');
  }

  return {
    id: 0, // Will be assigned by PersonManager
    name: obj.name,
    email: obj.email,
    age: obj.age,
    isActive: true,
    createdAt: new Date(),
  };
}

// Main function for testing
async function main(): Promise<void> {
  console.log('TypeScript Neovim Test Application');
  console.log('='.repeat(40));

  // Test PersonManager
  const manager = new PersonManager();
  const people = await manager.getAllPeople();

  console.log(`\nFound ${people.length} people:`);
  people.forEach((person, index) => {
    const status = person.isActive ? 'active' : 'inactive';
    console.log(`${index + 1}: ${person.name} (${person.age}) - ${status}`);
  });

  // Test Calculator
  const calc = new Calculator();
  console.log(`\n5 + 3 = ${calc.add(5, 3)}`);
  console.log(`10 / 2 = ${calc.divide(10, 2)}`);

  const numbers = [1, 2, 3, 4, 5];
  const average = calc.calculateAverage(numbers);
  console.log(`Average of [${numbers.join(', ')}] = ${average}`);

  // Test search functionality
  const results = manager.searchPeople('alice');
  console.log(`\nSearch results for 'alice': ${results.length} found`);

  // Test error handling
  try {
    const invalidResult = calc.divide(10, 0);
    console.log(`Division result: ${invalidResult}`);
  } catch (error) {
    console.error(`Caught error: ${error.message}`);
  }

  try {
    const invalidPerson = processPersonData({ name: 'Test' }); // Missing required fields
    console.log(`Processed person: ${invalidPerson.name}`);
  } catch (error) {
    console.error(`Validation error: ${error.message}`);
  }

  console.log('\nTest completed successfully!');
}

// Export for testing and run if main module
if (require.main === module) {
  main().catch((error) => {
    console.error('Application error:', error);
    process.exit(1);
  });
}