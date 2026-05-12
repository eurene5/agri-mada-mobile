import pytest


@pytest.mark.asyncio
async def test_journal_sans_token_retourne_401(async_client):
    response = await async_client.get('/api/journal/')

    assert response.status_code == 401


@pytest.mark.asyncio
async def test_journal_avec_token_retourne_200(async_client, auth_headers):
    response = await async_client.get('/api/journal/', headers=auth_headers)

    assert response.status_code == 200
    payload = response.json()
    assert 'parcelles' in payload
    assert 'total_parcelles' in payload


@pytest.mark.asyncio
async def test_journal_detail_parcelle_valide_retourne_200(
    async_client,
    auth_headers,
    user_parcelle,
):
    response = await async_client.get(
        f'/api/journal/parcelle/{user_parcelle.id}',
        headers=auth_headers,
    )

    assert response.status_code == 200
    assert isinstance(response.json(), list)


@pytest.mark.asyncio
async def test_journal_detail_parcelle_invalide_retourne_404(async_client, auth_headers):
    response = await async_client.get('/api/journal/parcelle/99999', headers=auth_headers)

    assert response.status_code == 404
