#!/usr/bin/python3
"""
Function that queries the Reddit API and prints the titles
of the first 10 hot posts listed for a given subreddit.
"""

import requests

def top_ten(subreddit):
    # Reddit API endpoint for getting the hot posts of a subreddit
    url = f'https://www.reddit.com/r/{subreddit}/hot.json?limit=10'
    
    # Set a custom user-agent to avoid getting blocked
    headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'}
    
    # Make the request to the Reddit API
    response = requests.get(url, headers=headers)

    # Check if the request was successful (status code 200)
    if response.status_code == 200:
        # Extract the JSON data from the response
        data = response.json()

        # Check if the subreddit exists
        if 'error' in data:
            print(None)
        else:
            # Print the titles of the first 10 hot posts
            for post in data['data']['children']:
                print(post['data']['title'])
    else:
        print(None)

# Example usage
if __name__ == '__main__':
    import sys

    if len(sys.argv) < 2:
        print("Please pass an argument for the subreddit to search.")
    else:
        top_ten(sys.argv[1])
