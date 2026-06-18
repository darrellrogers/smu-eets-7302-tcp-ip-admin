def main():
    names = []
    status = {}
    gifts = {}

    print("Enter up to 10 names. Type 'done' to finish early.")

    # Collect up to 10 names
    for i in range(10):
        name = input(f"Enter name {i+1}: ").strip()
        if name.lower() == 'done':
            break
        if name:
            names.append(name)

    # Determine if each person is naughty or nice
    for name in names:
        while True:
            category = input(f"Is {name} naughty or nice? ").strip().lower()
            if category in ['naughty', 'nice']:
                status[name] = category
                break
            else:
                print("Please enter 'naughty' or 'nice'.")

    # Ask for a gift for each person
    for name in names:
        gift = input(f"Enter a gift for {name} ({status[name]}): ").strip()
        gifts[name] = gift

    # Display the results
    print("\nSummary:")
    for name in names:
        print(f"{name} is {status[name]} and will receive: {gifts[name]}")

if __name__ == "__main__":
    main()
