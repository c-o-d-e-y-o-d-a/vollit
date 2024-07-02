from flask import Flask, request
from dotenv import load_dotenv
from moralis import evm_api
from flask_restful import Api, Resource
import json
import os

load_dotenv()

app = Flask(__name__)
api = Api(app)  # Initialize the Api object with the Flask app
api_key = os.getenv("MORALIS_API_KEY")

@app.route("/get_token_balance", methods=['GET'])
def get_tokens():
    chain = request.args.get('chain')
    address = request.args.get('address')
    
    params = {
        "chain": chain,
        "address": address
    }

    result = evm_api.balance.get_native_balance(
        api_key=api_key,
        params=params,
    )
    return json.dumps(result, indent=4)  # Ensure the result is returned as JSON

# Example data
names = {
    "tim": {"age": 19, "gender": "male"},
    "bill": {"age": 23, "gender": "female"}
}

class GetToken(Resource):
    def get(self, name):
        if name in names:
            return names[name]
        return {"error": "Name not found"}, 404

api.add_resource(GetToken, "/gettoken/<string:name>/")  # Correct the URL format

class Basic(Resource):
    def get(self):
        return 'this shit works lol'

api.add_resource(Basic, '/')

class GetUserNFTs(Resource):
    def get(self, chain, address):
        params = {
            "address": address,
            "chain": chain,
            "format": "decimal",
            "limit": 100,
            "token_addresses": [],
            "cursor": "",
            "normalizeMetadata": True,
        }
        result = evm_api.nft.get_wallet_nfts(
            api_key=api_key,
            params=params
        )
        response = json.dumps(result, indent=4)
        return response

api.add_resource(GetUserNFTs, "/get-user-nfts/<string:chain>/<string:address>")  # Correct the URL format

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5002, debug=True)
