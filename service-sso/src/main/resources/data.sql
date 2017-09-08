INSERT INTO oauth_client_details
(client_id, resource_ids, client_secret, scope, authorized_grant_types, web_server_redirect_uri,
 authorities, access_token_validity, refresh_token_validity, additional_information, autoapprove)
VALUES (
  'client', 'user-res', 'secret', 'read,write', 'authorization_code,password,refresh_token', 'https://www.baidu.com',
            'ROLE_CLIENT', 0, 0, NULL, 'false'
);