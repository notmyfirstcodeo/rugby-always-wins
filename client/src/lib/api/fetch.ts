/**
 * Helper to make GET requests to the API.
 * @param url - The endpoint URL to append to the base API URL
 * @param reqInit - Any additional request configurations (headers, body, etc.)
 * @returns The parsed JSON response from the API
 */
export async function fetchAPI<T>(
  url: string,
  reqInit?: RequestInit
): Promise<T> {
  const baseUrl = process.env.NEXT_PUBLIC_API_BASE_URL || '';

  try {
    const res = await fetch(`${baseUrl}${url}`, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
      },
      ...reqInit,
    });

    if (!res.ok) {
      const error = {
        info: null,
        status: 500,
        ...new Error('An error occurred while fetching the data.'),
      };
      error.info = await res.json();
      error.status = res.status;
      throw error;
    }

    return res.json();
  } catch (error) {
    throw new Error(`Failed to fetch: ${error}`);
  }
}
